package options;

#if desktop
import Discord.DiscordClient;
#end
import flash.text.TextField;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.addons.display.FlxGridOverlay;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.math.FlxMath;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import lime.utils.Assets;
import flixel.FlxSubState;
import flash.text.TextField;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.util.FlxSave;
import haxe.Json;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.util.FlxTimer;
import flixel.input.keyboard.FlxKey;
import flixel.graphics.FlxGraphic;
import Controls;

using StringTools;

class LanguageState extends MusicBeatState
{
	private var grpLang:FlxTypedGroup<Alphabet>;

	private static var curSelected:Int = 0;
	public static var menuBG:FlxSprite;
	
	var lang:Array<String> = ['en', 'fr'];
	private var iconArray:Array<AttachedSprite> = [];

	override function create()
	{
		#if desktop
		DiscordClient.changePresence("Language Menu", null);
		#end

		var bg:FlxSprite = new FlxSprite().loadGraphic(Paths.image('menuDesat'));
		bg.color = 0xFF009900;
		bg.updateHitbox();

		bg.screenCenter();
		bg.antialiasing = ClientPrefs.globalAntialiasing;
		add(bg);

		grpLang = new FlxTypedGroup<Alphabet>();
		add(grpLang);

		for (i in 0...lang.length)
		{
			var langText:Alphabet = new Alphabet(0, 0, lang[i], true, false);
			langText.isMenuItem = true;
			langText.y += (100 * (i - ((lang.length) / 2))) + 50;
			langText.x += 300;
			grpLang.add(langText);

			var icon:AttachedSprite = new AttachedSprite();
			icon.frames = Paths.getSparrowAtlas('languages/' + lang[i]);
			icon.animation.addByPrefix('idle', lang[i], 24);
			icon.animation.play('idle');
			icon.xAdd = -icon.width - 10;
			icon.sprTracker = langText;

			// using a FlxGroup is too much fuss!
			iconArray.push(icon);
			add(icon);
		}

		var titleText:Alphabet = new Alphabet(0, 0, Language.language, true, false, 0, 0.6);
		titleText.x += 60;
		titleText.y += 40;
		titleText.alpha = 0.4;
		add(titleText);

		curSelected = 0;
		changeSelection();

                #if mobileC
                addVirtualPad(FULL, A_B);	
                #end

		super.create();
	}

	override function closeSubState()
	{
		super.closeSubState();
		ClientPrefs.saveSettings();
	}

	override function update(elapsed:Float)
	{
		super.update(elapsed);

		if (controls.UI_UP_P)
		{
			changeSelection(-1);
		}
		if (controls.UI_DOWN_P)
		{
			changeSelection(1);
		}

		if (controls.BACK)
		{
			FlxG.sound.play(Paths.sound('cancelMenu'));
			if (lang[curSelected == 'fr')
                        {
                                MusicBeatState.switchState(new OptionsStateFr());
                        }
                        else
                        {
                                MusicBeatState.switchState(new OptionsStateFr());
                        }
		}

		if (controls.ACCEPT)
		{
			ClientPrefs.language = lang[curSelected];
			Reflect.setProperty(ClientPrefs, 'language', lang[curSelected]);
			ClientPrefs.saveSettings();
			Language.regenerateLang(lang[curSelected]);
			FlxG.sound.play(Paths.sound('confirmMenu'));
                        if (lang[curSelected == 'fr')
                        {
                                MusicBeatState.switchState(new OptionsStateFr());
                        }
                        else
                        {
                                MusicBeatState.switchState(new OptionsStateFr());
                        }
		}
	}

	function changeSelection(change:Int = 0)
	{
		curSelected += change;
		if (curSelected < 0)
			curSelected = lang.length - 1;
		if (curSelected >= lang.length)
			curSelected = 0;

		var bullShit:Int = 0;

		for (item in grpLang.members)
		{
			item.targetY = bullShit - curSelected;
			bullShit++;

			item.alpha = 0.6;
			if (item.targetY == 0)
			{
				item.alpha = 1;
			}
		}
		FlxG.sound.play(Paths.sound('scrollMenu'));
	}
}
