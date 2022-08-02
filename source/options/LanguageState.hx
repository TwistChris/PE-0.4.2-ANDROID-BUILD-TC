package options;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.text.FlxText;
import flixel.util.FlxTimer;
import flixel.util.FlxColor;
import lime.utils.Assets;
import flixel.addons.transition.FlxTransitionableState;

class LanguageState extends MusicBeatState
{
    public static var leftState:Bool = false;

    var text:FlxText;
    var charSelHeaderText:FlxText;

    var bg:FlxSprite;

    var bglines:FlxSprite;

    var lang:Array<String> = ['english', 'francais'];

    public static var onComplete:() -> Void;

    var curSelected:Int = 0;
    
    override function create()
    {
        bg = new FlxSprite().loadGraphic(Paths.image("fragEn"));
		bg.setGraphicSize(Std.int(bg.width * 1.1));
		bg.updateHitbox();
		bg.screenCenter();
		bg.antialiasing = FlxG.save.data.antialiasing;
		add(bg);

        bglines = new FlxSprite().loadGraphic(Paths.image("blackLines"));
		bglines.setGraphicSize(Std.int(bg.width * 1.1));
		bglines.updateHitbox();
		bglines.screenCenter();
		bglines.antialiasing = FlxG.save.data.antialiasing;
		add(bglines);

        text = new FlxText(0, 0, FlxG.width, '', 32);
        text.setFormat(Paths.font('fullphanmuff.ttf'), 29, FlxColor.WHITE, CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
        text.text = '< Ъуъ >';
        text.screenCenter(X);
        text.screenCenter(Y);
        text.scrollFactor.set();
        add(text);

        charSelHeaderText = new FlxText(0, 0, FlxG.width, '', 32);
        charSelHeaderText.text = 'Language Select';
        charSelHeaderText.setFormat(Paths.font('fullphanmuff.ttf'), 32, FlxColor.WHITE, CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
        charSelHeaderText.screenCenter(X);
        charSelHeaderText.y += 20;
        add(charSelHeaderText);

        #if mobileC
        addVirtualPad(FULL, A_B);	
        #end

        super.create();
    }

    override function update(elapsed:Float) {
                text.text = "< " + lang[curSelected] + " >";

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

                       PreferencesSubstate.languagescore = lang[curSelected];
                       PlayState.languagescore = lang[curSelected];
                       ClientPrefs.language = lang[curSelected];
		       Reflect.setProperty(ClientPrefs, 'language', lang[curSelected]);
		       ClientPrefs.saveSettings();
                       Language.regenerateLang(lang[curSelected]);
		       FlxG.sound.play(Paths.sound('confirmMenu'));
		       MusicBeatState.switchState(new OptionsState());
                }

        super.update(elapsed);
    }

    function changeSelected(change:Int = 0):Void
    {
        curSelected += change;
    
        if (curSelected >= lang.length)
            curSelected = 0;
        if (curSelected < 0)
            curSelected = lang.length - 1;

        FlxG.sound.play(Paths.sound('scrollMenu'));

        charCheck();
    }

    function charCheck()
    {
         var langcurselc:String = lang[curSelected];

         switch (langcurselc)
         {
                case 'english':
                      bg.loadGraphic(Paths.image('fragEn'));
                      charSelHeaderText.text = 'Language Select';
                case 'francais':
                      bg.loadGraphic(Paths.image('fragFr'));
                      charSelHeaderText.text = 'Selection de la langue';
                default:
                      bg.loadGraphic(Paths.image('fragEn'));
                      charSelHeaderText.text = 'Language Select';
         }
    }
                       
}
