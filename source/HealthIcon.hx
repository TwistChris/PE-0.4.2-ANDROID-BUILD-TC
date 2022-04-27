package;

import flixel.FlxG;
import flixel.graphics.FlxGraphic;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.FlxSprite;
import openfl.utils.Assets as OpenFlAssets;

using StringTools;

class HealthIcon extends FlxSprite
{
	public var sprTracker:FlxSprite;
	private var isOldIcon:Bool = false;
	private var isPlayer:Bool = false;
	private var char:String = '';

        public var initialWidth:Float = 0;
	public var initialHeight:Float = 0;

        public var offsetX = 0;
	public var offsetY = 0;

        public var originalFlipX:Bool = false;

	public function new(char:String = 'bf', isPlayer:Bool = false)
	{
		super();
		isOldIcon = (char == 'bf-old');
		this.isPlayer = isPlayer;
		changeIcon(char);
		scrollFactor.set();
	}

	override function update(elapsed:Float)
	{
		super.update(elapsed);

		if (sprTracker != null)
			setPosition(sprTracker.x + sprTracker.width + 10, sprTracker.y - 30);
	}

	public function swapOldIcon() {
		if(isOldIcon = !isOldIcon) changeIcon('bf-old');
		else changeIcon('bf');
	}

	public function changeIcon(char:String) {
		if(this.char != char) {
                        offsetX = 0;
			offsetY = 0;
                        originalFlipX = flipX;
			switch (char) {
                                case 'matt-final':
					var file:FlxAtlasFrames = Paths.getSparrowAtlas('icons/Put_Your_Animated_Icon_Name_Here');
					frames = file;
					
					animation.addByPrefix(char, 'idle', 24, true);
					animation.play(char, false);

                                        offsetY = -24;

                                        flipX = true;
                                case 'mom':
                                        var file:FlxAtlasFrames = Paths.getSparrowAtlas('icons/NightmareskyIcons');
					frames = file;
					
					animation.addByPrefix(char, 'ManifestNormalIcon', 25, true);
					animation.play(char, false);
                                case 'bf' | 'dad':
                                        var name:String = 'icons/' + char;
			                if(!Paths.fileExists('images/' + name + '.png', IMAGE)) name = 'icons/icon-' + char; //Older versions of psych engine's support
			                if(!Paths.fileExists('images/' + name + '.png', IMAGE)) name = 'icons/icon-face'; //Prevents crash from missing icon

			                // lmao dont mind me just importing forever's dynamic healthicons
				        var iconGraphic:FlxGraphic = FlxG.bitmap.add(Paths.image(name));
				        loadGraphic(iconGraphic, true, Std.int(iconGraphic.width / 3), iconGraphic.height);
			
			                animation.add(char, [0, 1, 2], 0, false, isPlayer);
			                animation.play(char);
			                updateHitbox();
                                default:
			                var name:String = 'icons/' + char;
			                if(!Paths.fileExists('images/' + name + '.png', IMAGE)) name = 'icons/icon-' + char; //Older versions of psych engine's support
			                if(!Paths.fileExists('images/' + name + '.png', IMAGE)) name = 'icons/icon-face'; //Prevents crash from missing icon

			                // lmao dont mind me just importing forever's dynamic healthicons
				        var iconGraphic:FlxGraphic = FlxG.bitmap.add(Paths.image(name));
				        loadGraphic(iconGraphic, true, Std.int(iconGraphic.width / 2), iconGraphic.height);
			
			                animation.add(char, [0, 1, 2], 0, false, isPlayer);
			                animation.play(char);
			                updateHitbox();
			}
                        this.char = char;

                        updateHitbox();
                        initialWidth = width;
			initialHeight = height;
		
			antialiasing = ClientPrefs.globalAntialiasing;
			if(char.endsWith('-pixel')) {
				antialiasing = false;

                        }
		}
	}

	public function getCharacter():String {
		return char;
	}
}
