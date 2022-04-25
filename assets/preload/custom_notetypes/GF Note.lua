function onCreate()
	--Iterate over all notes
	for i = 0, getProperty('unspawnNotes.length')-1 do
		--Check if the note is a Bullet Note
		if getPropertyFromGroup('unspawnNotes', i, 'noteType') == 'GF Note' then
			setPropertyFromGroup('unspawnNotes', i, 'texture', 'NOTE2_assets'); --Change texture
			setPropertyFromGroup('unspawnNotes', i, 'missHealth', 0.0); --Change amount of health to take when you miss like a fucking moron
		end
	end
	--debugPrint('Script started!')
end

local healthDrain = 0;
function noteMiss(id, noteData, noteType, isSustainNote)
	if noteType == 'GF Note' then
		-- health loss | || || |_
		--setProperty('health', getProperty('health') - 50.0);
		healthDrain = healthDrain + 50.0;
	end
end

function onUpdate(elapsed)
	if healthDrain > 0 then
		healthDrain = healthDrain - 0.0 * elapsed;
		setProperty('health', getProperty('health') - 0.1 * elapsed);
		if healthDrain < 0 then
			healthDrain = 0;
		end
	end
end
