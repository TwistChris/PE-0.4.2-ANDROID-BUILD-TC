local allowCountdown = true
function onStartCountdown()
	if not allowCountdown and isStoryMode and not seenCutscene then --Block the first countdown
		setProperty('inCutscene', false);
		startVideo('ughCutscene');
		allowCountdown = false;
		return Function_Stop;
	end
	return Function_Continue;
end
