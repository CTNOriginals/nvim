This issue was caused by a bash script: `~/home/ctn/.local/share/nvim/mason/bin/typescript-language-server`

in this script, it would search try to find the following file path: `$basedir/../typescript-language-server/lib/cli.mjs`
This path did not exist, but the file does exist in a dir somewhat deeper in the packages dir: `$basedir/../packages/typescript-language-server/node_modules/typescript-language-server/lib/cli.mjs`

The fix was implimented by changing that bash script to the following:

```bash
#!/bin/sh
basedir=$(dirname "$(echo "$0" | sed -e 's,\\,/,g')")

case `uname` in
    *CYGWIN*|*MINGW*|*MSYS*)
        if command -v cygpath > /dev/null 2>&1; then
            basedir=`cygpath -w "$basedir"`
        fi
    ;;
esac

if [ -x "$basedir/node" ]; then
  exec "$basedir/node"  "$basedir/../packages/typescript-language-server/node_modules/typescript-language-server/lib/cli.mjs" "$@"
else 
  exec node  "$basedir/../packages/typescript-language-server/node_modules/typescript-language-server/lib/cli.mjs" "$@"
fi
```