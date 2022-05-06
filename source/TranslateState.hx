package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.text.FlxText;
import flixel.util.FlxTimer;
import flixel.util.FlxColor;
import flixel.addons.transition.FlxTransitionableState;

class TranslateState extends MusicBeatState
{
    public static var leftState:Bool = false;

    var optionText:FlxText;
    var text:FlxText;

    var bg:FlxSprite;

    var languages:Array<String> = ['English','Français'];

    public static var onComplete:() -> Void;

    var curSelected:Int = 0;
    
    override public function create()
    {
        curSelected = FlxG.save.data.translationCS;
        
        bg = new FlxSprite().loadGraphic(Paths.image("menuDesat"));
		bg.color = 0xFFea71fd;
		bg.setGraphicSize(Std.int(bg.width * 1.1));
		bg.updateHitbox();
		bg.screenCenter();
		bg.antialiasing = FlxG.save.data.antialiasing;
		add(bg);

        text = new FlxText();
        text.setFormat(Paths.font('vcr.ttf'), 32, FlxColor.WHITE, RIGHT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
        text.text = '< Ъуъ >';
        text.screenCenter(X);
        text.screenCenter(Y);
        text.scrollFactor.set();
        add(text);

        var blabla:String = 'You can always choose the language you want in the options.';

        warnText = new FlxText(0, 0, FlxG.width,
	        blabla,
		32);
	warnText.setFormat("VCR OSD Mono", 32, FlxColor.WHITE, CENTER);
	warnText.screenCenter(X);
        warnText.y -= 20;
	add(warnText);

        switch (languages[curSelected])
        {
                case 'English':
                      blabla = 'You can always choose the language you want in the options.';
                case 'Français':
                      blabla = 'Tu peux toujours la langue que tu veux dans les options.';
                default:
                      blabla = 'You can always choose the language you want in the options.';
        }

        var langselc:String = 'Language Select';

        var charSelHeaderText:Alphabet = new Alphabet(0, 50, langselc, true, false);
        charSelHeaderText.screenCenter(X);
        add(charSelHeaderText);

        switch (languages[curSelected])
        {
                case 'English':
                      langselc = 'Language Select';
                case 'Français':
                      langselc = 'Sélection de la langue';
                default:
                      langselc = 'Language Select';
        }

        #if mobileC
        addVirtualPad(FULL, A_B);	
        #end

        super.create();
    }

    override public function update(elapsed:Float) {
        text.text = "< " + languages[curSelected] + " >";
        FlxG.save.data.language = languages[curSelected];
        FlxG.save.data.translationCS = curSelected;
        if(controls.UI_LEFT_P)
            changeSelected(-1);
        if(controls.UI_RIGHT_P)
            changeSelected(1);

        if(controls.BACK || controls.ACCEPT)
        {
            leftState = true;
	    FlxTransitionableState.skipNextTransIn = true;
            FlxTransitionableState.skipNextTransOut = true;
            if (languages[curSelected] != 'English')
                MusicBeatState.switchState(new FlashingState());
            if (languages[curSelected] != "Français")
                MusicBeatState.switchState(new FlashingStateFr());
        }

        super.update(elapsed);
    }

    function changeSelected(change:Int = 0):Void
    {
        curSelected += change;
    
        if (curSelected >= languages.length)
            curSelected = 0;
        if (curSelected < 0)
            curSelected = languages.length - 1;

        FlxG.sound.play(Paths.sound('scrollMenu'));
    }
}
