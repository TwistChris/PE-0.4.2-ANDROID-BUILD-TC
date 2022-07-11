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
    var charSelHeaderText:FlxText;

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

        warnText = new FlxText(0, 0, FlxG.width,
	        '',
		32);
	warnText.setFormat("VCR OSD Mono", 32, FlxColor.WHITE, CENTER);
        warnText.text = 'You can always choose the language that you want in the options.';
	warnText.screenCenter(X);
        warnText.y += 70;
	add(warnText);

        charSelHeaderText = new FlxText(0, 0, FlxG.width, '', 50);
        charSelHeaderText.text = 'Language Select';
        warnText.setFormat("VCR OSD Mono", 32, FlxColor.WHITE, CENTER);
        charSelHeaderText.screenCenter(X);
        warnText.y += 20;
        add(charSelHeaderText);

        #if mobileC
        addVirtualPad(FULL, A_B);	
        #end

        super.create();
    }

    override function update(elapsed:Float) {
                text.text = "< " + languages[curSelected] + " >";

                if (controls.UI_LEFT_P)
	        {
                       changeSelected(-1);
	        }

	        if (controls.UI_RIGHT_P)
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
                       ClientPrefs.translate = false;
                       var langcurselc:String = languages[curSelected];

                       ClientPrefs.language = langcurselc;
		       Reflect.setProperty(ClientPrefs, 'language', langcurselc);
		       ClientPrefs.saveSettings();
		       Language.regenerateLang(langcurselc);
		       FlxG.sound.play(Paths.sound('confirmMenu'));
		       MusicBeatState.switchState(new FlashingState());
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

        charCheck();
    }

    function charCheck()
    {
         var langcurselc:String = languages[curSelected];

         switch (langcurselc)
         {
                case 'English':
                      warnText.text = 'You can always choose the language that you want in the options.';
                      charSelHeaderText.text = 'Language Select';
                case 'Français':
                      warnText.text = 'Tu peux toujours la langue que tu veux dans les options.';
                      charSelHeaderText.text = 'Selection de la langue';
                default:
                      warnText.text = 'You can always choose the language that you want in the options.';
                      charSelHeaderText.text = 'Language Select';
         }
    }
                       
}
