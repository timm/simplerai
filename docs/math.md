<button class="button button1"><a href=/fun/index>home</a></button>
<button class="button button2"><a href=/fun/INSTALL>install</a></button>
<button class="button button1"><a href=/fun/ABOUT>doc</a></button>
<button class="button button2"><a href=http://github.com/timm/fun/issues>discuss</a></button>
<button class="button button1"><a href=/fun/LICENSE>license</a></button>

```awk
function min(x,y) { return x<y?    x : y }
```
```awk
function max(x,y) { return x>y?    x : y }
```
```awk
function abs(x)   { return x<0? -1*x : x }
```

```awk
function gauss(m,s) { return m + s*z() }
```
```awk
function z() { 
  return sqrt(-2*log(rand()))*cos(6.2831853*rand())
}
```

