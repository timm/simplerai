<button class="button button1"><a href=/fun/index>home</a></button>
<button class="button button2"><a href=/fun/INSTALL>install</a></button>
<button class="button button1"><a href=/fun/ABOUT>doc</a></button>
<button class="button button2"><a href=http://github.com/timm/fun/issues>discuss</a></button>
<button class="button button1"><a href=/fun/LICENSE>license</a></button>

```awk
function Globals(i) {
  i.dot  = sprintf("%c",46)
  i.some.magic  = 2.56
  i.some.max    = 256
  i.stats.cliffs.small   = 0.147
}
```

```awk
BEGIN { Globals(FUN) }
```