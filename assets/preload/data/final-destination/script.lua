
local xx = 520;
local yy = 550;
local xx2 = 820;
local yy2 = 410;
local xx3 = 520;
local yy3 = 410;
local ofs = 35;
local followchars = true;
local del = 0;
local del2 = 0;
local del3 = 0;


function onUpdate()
	if del > 0 then
		del = del - 1
	end
	if del2 > 0 then
		del2 = del2 - 1
	end
        if del3 > 0 then
		del3 = del3 - 1
	end
    if followchars == true then
        if mustHitSection == false then
            if getProperty('dad.animation.curAnim.name') == 'singLEFT' then
                triggerEvent('Camera Follow Pos',xx-ofs,yy)
            end
            if getProperty('dad.animation.curAnim.name') == 'singRIGHT' then
                triggerEvent('Camera Follow Pos',xx+ofs,yy)
            end
            if getProperty('dad.animation.curAnim.name') == 'singUP' then
                triggerEvent('Camera Follow Pos',xx,yy-ofs)
            end
            if getProperty('dad.animation.curAnim.name') == 'singDOWN' then
                triggerEvent('Camera Follow Pos',xx,yy+ofs)
            end
            if getProperty('dad.animation.curAnim.name') == 'singLEFT-alt' then
                triggerEvent('Camera Follow Pos',xx-ofs,yy)
            end
            if getProperty('dad.animation.curAnim.name') == 'singRIGHT-alt' then
                triggerEvent('Camera Follow Pos',xx+ofs,yy)
            end
            if getProperty('dad.animation.curAnim.name') == 'singUP-alt' then
                triggerEvent('Camera Follow Pos',xx,yy-ofs)
            end
            if getProperty('dad.animation.curAnim.name') == 'singDOWN-alt' then
                triggerEvent('Camera Follow Pos',xx,yy+ofs)
            end
            if getProperty('dad.animation.curAnim.name') == 'idle-alt' then
                triggerEvent('Camera Follow Pos',xx,yy)
            end
            if getProperty('dad.animation.curAnim.name') == 'idle' then
                triggerEvent('Camera Follow Pos',xx,yy)
            end
        else

            if getProperty('boyfriend.animation.curAnim.name') == 'singLEFT' then
                triggerEvent('Camera Follow Pos',xx2-ofs,yy2)
            end
            if getProperty('boyfriend.animation.curAnim.name') == 'singRIGHT' then
                triggerEvent('Camera Follow Pos',xx2+ofs,yy2)
            end
            if getProperty('boyfriend.animation.curAnim.name') == 'singUP' then
                triggerEvent('Camera Follow Pos',xx2,yy2-ofs)
            end
            if getProperty('boyfriend.animation.curAnim.name') == 'singDOWN' then
                triggerEvent('Camera Follow Pos',xx2,yy2+ofs)
            end
	    if getProperty('boyfriend.animation.curAnim.name') == 'idle' then
                triggerEvent('Camera Follow Pos',xx2,yy2)
            end
        else

            if getProperty('dad2.animation.curAnim.name') == 'singLEFT' then
                triggerEvent('Camera Follow Pos',xx3-ofs,yy3)
            end
            if getProperty('dad2.animation.curAnim.name') == 'singRIGHT' then
                triggerEvent('Camera Follow Pos',xx3+ofs,yy3)
            end
            if getProperty('dad2.animation.curAnim.name') == 'singUP' then
                triggerEvent('Camera Follow Pos',xx3,yy3-ofs)
            end
            if getProperty('dad2.animation.curAnim.name') == 'singDOWN' then
                triggerEvent('Camera Follow Pos',xx3,yy3+ofs)
            end
	    if getProperty('dad2.animation.curAnim.name') == 'idle' then
                triggerEvent('Camera Follow Pos',xx3,yy3)
            end
        end
    else
        triggerEvent('Camera Follow Pos','','')
    end
    
end
