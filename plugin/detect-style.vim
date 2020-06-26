
function! <SID>DetectAll()
    call <SID>DetectQuotes()
    call <SID>DetectSemi()
endfunction

function! <SID>DetectSemi()
    let withSemi = <SID>Count('[)''"];$')
    let withoutSemi = <SID>Count('[)''"]$')

    if withoutSemi > withSemi
        let b:usedSemi = 0
    else
        let b:usedSemi = 1
    endif

    return b:usedSemi
endfunction

function! <SID>DetectQuotes()
    let simpleQuotes = <SID>Count('''')
    let doubleQuotes = <SID>Count('"')

    if simpleQuotes > doubleQuotes
        let b:usedQuotes = ''''
    else
        let b:usedQuotes = '"'
    endif

    return b:usedQuotes
endfunction

function! <SID>Count(rx)
    let save = winsaveview()

    call setpos('.', [0, 1, 1, 0])

    let count=0

    while search(a:rx, 'W') != 0
        let count += 1

        if count > 1000
            break
        endif
    endwhile

    call winrestview(save)

    return count
endfunction


command! -bar -nargs=0 DetectStyle call <SID>DetectAll()
