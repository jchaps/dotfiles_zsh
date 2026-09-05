#!/bin/sh
#
# Shared helpers for interactive/batch install prompts.
# $INTERACTIVE is set by install.sh before this is sourced: "1" = interactive,
# anything else (including unset) = batch, in which case every helper below
# is a no-op that proceeds/selects everything, preserving today's behavior.

# confirm_step "description"
# Asks a yes/no question. Returns 0 (proceed) on anything but an "n" answer.
# In batch mode, always returns 0 without prompting.
confirm_step() {
    if [ "$INTERACTIVE" != "1" ]
    then
        return 0
    fi

    printf '%s [Y/n] ' "$1" >&2
    read -r reply
    case "$reply" in
        [nN]*) return 1 ;;
        *) return 0 ;;
    esac
}

# select_items "prompt" item1 item2 ...
# Prints the chosen items, one per line, to stdout (everything else goes to
# stderr so it doesn't pollute the selection). In batch mode, every item is
# selected without prompting -- same result as today's fixed lists.
select_items() {
    prompt=$1
    shift

    if [ "$INTERACTIVE" != "1" ]
    then
        printf '%s\n' "$@"
        return 0
    fi

    echo "$prompt" >&2
    i=1
    for item in "$@"
    do
        printf '  %d) %s\n' "$i" "$item" >&2
        i=$((i + 1))
    done
    printf 'Numbers to install (space-separated), "a"=all, "n"=none [a]: ' >&2
    read -r reply
    reply=${reply:-a}

    case "$reply" in
        a|A) printf '%s\n' "$@" ;;
        n|N) ;;
        *)
            i=1
            for item in "$@"
            do
                for n in $reply
                do
                    [ "$n" = "$i" ] && printf '%s\n' "$item"
                done
                i=$((i + 1))
            done
            ;;
    esac
}
