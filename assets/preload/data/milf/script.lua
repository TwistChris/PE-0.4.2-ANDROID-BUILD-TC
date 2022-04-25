function opponentNoteHit(id, direction, noteType, isSustainNote)  

    cameraShake('game', 0.01, 0.1)
    health = getProperty('health')
    if getProperty('health') > 0.05 then
        setProperty('health', health- 0.005);
    end
end