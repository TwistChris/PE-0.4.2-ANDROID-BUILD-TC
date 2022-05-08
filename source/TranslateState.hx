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

    var warnText:FlxText;
    var text:FlxText;

    var bg:FlxSprite;

    var languages:Array<String> = ['English', 'Français'];

    public static var onComplete:() -> Void;

    var curSelected:Int = 0;
    
    override function create()
    {
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

        var blabla:String = '';

        warnText = new FlxText(0, 0, FlxG.width,
	        blabla,
		32);
	warnText.setFormat("VCR OSD Mono", 32, FlxColor.WHITE, CENTER);
	warnText.screenCenter(X);
        warnText.y += 20;
	add(warnText);

        var langcurselc:String = languages[curSelected];

        switch (langcurselc)
        {
                case 'English':
                      blabla = 'You can always choose the language that you want in the options.';
                case 'Français':
                      blabla = 'Tu peux toujours la langue que tu veux dans les options.';
                default:
                      blabla = '';
        }

        var langselc:String = '';

        var charSelHeaderText:Alphabet = new Alphabet(0, 50, langselc, true, false);
        charSelHeaderText.screenCenter(X);
        add(charSelHeaderText);

        switch (langcurselc)
        {
                case 'English':
                      langselc = 'Language Select';
                case 'Français':
                      langselc = 'Sélection de la langue';
                default:
                      langselc = '';
        }

        #if mobileC
        addVirtualPad(FULL, A_B);	
        #end

        super.create();
    }

    override function update(elapsed:Float) {
                text.text = "< " + languages[curSelected] + " >";

                if (controls.UI_UP_P)
	        {
                       changeSelected(-1);
	        }

	        if (controls.UI_DOWN_P)
	        {
	               changeSelected(1);
                }

                if (controls.BACK)
                {
                       FlxG.sound.play(Paths.sound('cancelMenu'));
                }

                if(controls.ACCEPT) {
                       leftState = true;
	               FlxTransitionableState.skipNextTransIn = true;
                       FlxTransitionableState.skipNextTransOut = true;
                       FlxG.sound.play(Paths.sound('confirmMenu'));
                       var langcurselc:String = languages[curSelected];

                       switch (langcurselc)
                       {
		               case 'English':
		                      MusicBeatState.switchState(new FlashingState());
		               case 'Français':
		                      MusicBeatState.switchState(new FlashingStateFr());
	               }
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
