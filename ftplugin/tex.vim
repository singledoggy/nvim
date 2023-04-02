
function! LatRe()
:silent! %s/\<SO2\>/\\ch{SO_2} /g
:silent! %s/\<PM10\>/\\ch{PM_{10}} /g
:silent! %s/\<PM25\>/\\ch{PM_{2.5}} /g
:silent! %s/\<PM2.5\>/\\ch{PM_{2.5}} /g
:silent! %s/\<NO2\>/\\ch{NO_2} /g
:silent! %s/\<O3\>/\\ch{O_3} /g
:silent! %s/\<NO[xX]\>/\\ch{NO_x} /g
endfunc

command! LatRe  call LatRe()

function! LatReMtC()
:silent! %s/\V$\\mathrm{SO_2}$/\\ch{SO_2} /g
:silent! %s/\V$\\mathrm{PM_{10}}$/\\ch{PM_{10}} /g
:silent! %s/\V$\\mathrm{PM_{2.5}}$/\\ch{PM_{2.5}} /g
:silent! %s/\V$\\mathrm{NO_2}$/\\ch{NO_2} /g
:silent! %s/\V$\\mathrm{O_3}$/\\ch{O_3} /g
:silent! %s/\V$\\mathrm{NO_x}$/\\ch{NO_x} /g
endfunc
command! LatReMtC  call LatReMtC()

function! LatReCtM()
:silent! %s/\\ch{SO_2}/$\\mathrm{SO_2}$ /g
:silent! %s/\\ch{PM_{10}}/$\\mathrm{PM_{10}} $/g
:silent! %s/\\ch{PM_{2.5}}/$\\mathrm{PM_{2.5}}$ /g
:silent! %s/\\ch{NO_2}/$\\mathrm{NO_2}$ /g
:silent! %s/\\ch{O_3}/$\\mathrm{O_3}$ /g
:silent! %s/\\ch{NO_x}/$\\mathrm{NO_x}$ /g
endfunc
command! LatReCtM  call LatReCtM()
