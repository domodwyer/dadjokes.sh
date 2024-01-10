## dadjokes.sh

A script to fetch the latest, greatest dad jokes from [icanhazdadjoke] and
output a bash script that spits out random nuggets of pure comedy gold. Ideally
[via a cow][cowsay].

```shell
dadjokes.sh % joke.sh | cowsay

 _______________________________________
/ Two fish are in a tank, one turns to  \
| the other and says, "how do you drive |
\ this thing?"                          /
 ---------------------------------------
        \   ^__^
         \  (oo)\_______
            (__)\       )\/\
                ||----w |
                ||     ||

```

### How To?

The script in this repo _generates_ a script that contains all the entries in
the excellent (terrible) [icanhazdadjoke] database, and emits them randomly.

```shell
# Fetch all the jokes and generate a joke emitting script
% ./dadjokes.sh > jokes.sh

# Ask a cow to say something funny
% ./jokes.sh | cowsay
```

Re-run `dadjokes.sh` to regenerate the joke script whenever you need the latest
wisdom in your life.

[icanhazdadjoke]: https://icanhazdadjoke.com/
[cowsay]: https://en.wikipedia.org/wiki/Cowsay
