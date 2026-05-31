#import "@local/utils:0.1.0": *
#import "@local/doc_fac:0.1.0" as theme_colors
#import "@local/doc_cours_nb:0.1.0" as theme_nb

#let theme_default = "colors"

#let theme_name = sys.inputs.at("theme", default: theme_default)


#let theme = if theme_name == "colors" { theme_colors } else { theme_nb }

#let theorem = theme.theorem
#let corollary = theme.corollary
#let lemma = theme.lemma
#let property = theme.property
#let proposition = theme.proposition
#let exercice = theme.exercice
#let example = theme.example
#let notation = theme.notation
#let remark = theme.remark
#let method = theme.method
#let definition = theme.definition
#let vocabulary = theme.vocabulary
#let proof = theme.proof

#let only-thms = sys.inputs.at("only-thms", default: "false") == "true"

#show: theme.doc_fac.with(
  title: "Cours Alg3-2",
  numbering: "I. 1. 1. a) i)",
  show-examples: not only-thms,
  show-exercises: not only-thms,
  show-proofs: not only-thms,
  page-numbering: "1",
)

#outline()

*Partiels*

#underline[CC1] : semaine "$-3$" du TD 50%

#underline[CC2] : dernière semaine de cours

= Séries génératrices
#definition[
  Soit $(a_n)_(n in NN)$ une suite de nombres réels.
  La série génératrice de $(a_n)_(n in NN)$ est la série entière $sum_(n = 0)^(infinity) a_n X^n$

  Si c'est une série qui converge vers une fonction alors on appelle la fonction la *fonction génératrice* de $(a_n)_(n in NN)$
]
#remark[
  En pratique, $a_n =$ la solution d'un problème de comptage qui dépend de $n$.
]

#example[
  Si $a_n$ est le nombre de moyens d'obtenir $n$ en lançant un dé
  $ a_n = cases(1 quad &"si" n in [|1,6|], 0 "sinon") $

  La série génératrice est donc : $0 + X + X^2 + ... + X^6$
]

#example[
  Si $a_n$ est le nombre de moyens d'obtenir $n$ en lançant deux dés.

  $a_1 = 0, a_2 = 1, a_3 = 2, dots$

  Pour trouver la série génératrice, on multiplie la série génératrice trouvée dans l'exemple précédent par elle-même.

  $
    (X + X^2 + ... + X^6)(X + X^2 + ... + X^6) = sum_(n in NN) a_n X^n
  $

  Ainsi, le coefficient en $n$ sera le nombre de manières d'obtenir $n$.
]

#example[
  Si on lance $m$ dés, la série génératrice est $(X + X^2 + dots + X^6)^m$
]

#example[

  Supposons que l'on ait $cases(6 "pièces de" 1 euro, 1 "billet de " 5 euro, 2 "pièces de "10 euro)$

  Et posons $a_n$ le nombre de combinaisons possibles pour fabriquer un montant de $n$ euros

  Ainsi la série génératrice est $(1 + X + X^2 + X^3 + X^4 + X^5 + X^6)(1 + X^5)(1 + X^10 + X^20)$
]

#example[
  Le même problème avec une infinité de pièces et billets, la série entière devient une série infinie :
  $
    (sum_(i = 0)^(infinity) X^k)(sum_(i = 0)^(infinity) X^(5k))(sum_(i = 0)^(infinity) X^(10k)) = 1/(1-X)cdot 1/(1-X^5) cdot 1/(1-X^10)
  $

  converge pour un $X$ assez proche de $0$ ($R = 1$)
]

#example[
  lancer un dé à $2$ faces $(1,2)$, on compte le nombre de manières possibles d'obtenir une somme $n$.

  Par exemple, $3 = 1 + 1 + 1 = 2 + 1 = 1 + 2$, donc $a_3 = 3$

  On représente ça par une relation de récurrence :

  Pour obtenir $n$ en $m$ lancers :

  On a 2 possibilités : soit le premier lancer donne $1$, soit il donne $2$. On va sommer les deux cas :
  + La somme des $m-1$ derniers lancers est $n-1$
  + La somme des $m-1$ derniers lancers est $n-2$

  Ainsi $a_n = a_(n-1) + a_(n-2)$

  Supposons que $sum_(n = 0)^(infinity) a_n X^n$ converge vers $f(X)$.

  On a :
  $
        f(X) = & a_0 + & a_1 X + & a_2 X^2 + ... \
      X f(X) = & 0 +   & a_0 X + & a_1 X^2 + ... \
    X^2 f(X) = & 0 +   &     0 + & a_0 X^2 + ... \
  $

  Ainsi :
  $
    X f(X) + X^2 f(X) = 0 + a_0 X + (a_0 + a_1)X^2 + (a_1 + a_2)X^3 + ... + (a_(n-1) + a_(n-2))X^n + ...
  $

  Donc $ X f(X) + X^2f(X) = 0 + a_0 X + sum_(n = 2)^(infinity) a_n X^n = a_0 - X - a_0 - a_1 X + f(X) $

  Par convention $a_0 = 1, a_1 = 1$

  Donc au final, on a :
  $(X + X^2)f(X) = f(X) - 1 <==> f(X) = 1/(1 - X - X^2)$

  on peut décomposer en éléments simples.

  les racines du polynôme au dénominateur sont $phi,psi = (1 +- sqrt(5))/2$

  et on trouve ainsi $f(X) = 1/sqrt(5) [(phi)/(1-(1/phi) X) - (psi)/(1-(1/psi) X)]$

  En développant en série enière :
  $
    f(X) & = sum_(n = 0)^(infinity)[1/sqrt(5) phi (1/phi)^n - 1/sqrt(5) psi (1/psi)^n]X^n \
         & = sum_(n=0)^(infinity) (phi^(1-n)-psi^(1-n))/sqrt(5)X^n
  $

]

#example[
  $C_j$ représente le nombre de possibilités de découper un polygone régulier à $j+2$ côtés en triangles.

  On trouve $C_1 = 1$, $C_2 = 2$, $C_3 = 5$

  Notons $(S_k)_(1 <=k<=j+2)$

  Étant donné un découpage, il existe un unique triangle avec le côté $bar(S_1 S_(j+2))$

  Le troisième sommet de ce triangle est un certain $S_k$

  // TODO illustrer si possible
  On peut partitionner le reste en un côté $A$ qui touche $bar(S_1 S_k)$ et un côté $B$ qui touche $bar(S_(j+2) S_k)$

  La partie $A$ est un polygone de $j+2-k+1 = j-k+3$ sommets

  La partie $B$ est un polygone de $k$ sommets.

  Ainsi pour $S_k$ fixé, le nombre de découpages est le nombre de découpages de $A$ multiplié par le nombre de découpages de $B$, soit $C_(j-k+1)cdot C_(k-2)$

  Ainsi $ C_j & = sum_(k = 2)^(j+1)C_(k-2)C_(j-k+1)
        = sum_(k=0)^(j-1) C_k C_(j-k-1) \
      & = sum_(k+l = j-1) C_k C_l $


  Par convention, on dira $C_0 = 1$

  on a donc $f(X) = 1 + sum_(j = 1)^(infinity)C_j X^j$

  $
    f(X)^2 = (sum_(j=1)^(infinity)C_j X^j)(sum_(l=1)^(infinity) C_l X^l) = sum_(n=0)^(infinity) (sum_(j+l=n) C_j C_l)X^n = sum_(n = 0)^infinity C_(n+1)X^n\
  $

  On a juste à bien indicer, et on obtient :
  $X f(X)^2 = sum_(n = 1)^infinity C_n X^n = f(X)$

  posons $y = f(X)$, on a alors $X Y^2 - Y + 1 = 0 <==> Y = (2 +- sqrt(1-4X))/(2X)$

  Cependant, on n'a qu'une solution possible. $Y$ vaut $1$ pour $X = 0$ d'après la convention, on doit trouver celle qui vaut bien $1$ en $0$.

  $
    (1-sqrt(1-4X))/(2X) = (1 - (1 - (4X)/2 + smallo_(x->0)(1)))/(2X) = (2X + smallo_(x->0)(1))/(2X) = 1
  $

  #underline["Rappel" du prof...]

  On utilise $(1+X)^(1/2) = sum_(n = 0)^(infinity) binom(1/2, n)X^n = sum_(n=0)^(infinity) (1/2 (1/2 - 1) ... (1/2 - (n-1)))/n! X^n$

  ainsi en l'évaluant en $-4X$ , on obtient :
  $sqrt(1-4X) = sum_(n=0)^(infinity) 2^n/n! (-1) ... (2n-3)...3cdot 1 cdot X^n$

  avec ça, on peut retrouver la série entière représentant $f$ et donc $C_j$ pour tout $j$. Finalement :
  $
    C_j = (2^j j! (2j -1) ...1)/((j+1)! j!)
  $

  Comme $2^j j! = 2 cdot 4 cdot 2j$, on a $ C_j = ((2j)!)/((j+1)! j!) = ((2j)!)/((j!)^2(j+1)) $
]


#theorem("Euclide")[
  Il existe un nombre infini de nombres premiers.
]
#proof[
  Supposons que $PP$ est fini, $PP = {p_1,dots,p_n}$.

  Posons $N = product_(i=1)^(n)p_i + 1$

  Alors pour tout $p_i$, $N equiv 1 mod p_i$, donc $N and p_i = 1$

  Ainsi $N$ n'est divisible par aucun $p_i$, contradiction.
]

#theorem("Bezout")[
  Soient $n, m in NN$, les deux propositions sont équivalentes :
  + $n and m = 1$
  + $exists a,b in ZZ, a n + b m = 1$
]

#proof[
  Par division euclidienne successive
]

#theorem("Lemme d'Euclide")[
  Soient $a,b,c in NN^*$ tels que $a and b = 1$

  Alors :
  + $a divides b c ==> a divides c$
  + $a divides c, b divides c ==> a b divides c$
]

#proof[
  + Supposons que $a divides b c$

    Par le théorème de Bézout, on peut trouver $k,l in ZZ$ tels que $l a + l b = 1$

    Donc $c = c cdot 1 = c k a + c l b$

    Comme $a divides c l b$ et $a divides c k a$, on a $a divides c$
  + Suppposons $a divides c, b divides c$. Alors posons $c = b k$, $k in NN$

    Par le $1)$, $a divides k$. Donc $j = a l$ avec $l in NN$. Par conséquent $c = a b l$
]

#theorem[
  Soient $a,b in NN^*$. Alors $(a and b)(a or b) = a b$
]

#proof[
  On note $d = a and b$

  On écrit $a = d r$, $b = d s$ avec $r,s in NN$

  Pour démontrer le théorème, il suffit de montrer que $a or b = d r s$

  Évidemment, $d r s$ est un multiple commun de $a,b$.

  Supposons que $M$ est un multiple commun de $a,b$.

  Il reste à mq $M >= d r s$

  Comme $a divides M$, on a $M = a k = d r k$ avec $k in NN$

  De même, on a $M = b l = d s l$ avec $l in NN$.

  On pose $P = M/d$. On a $P in NN$ car $d divides M$

  On a $p = r k = s l$

  #underline[Remarque] : $a = d r, b = d s$. On a $r and s = 1$, car sinon $a and b > d$

  Comme $r k = P = s l$, on a $r divides s l = P$

  D'après le lemme d'Euclide, $r divides l$.

  Ainsi $l >= r$. Par conséquent, $M = d s l >= d s r$
]

#theorem("Fondamental de l'Arithmétique")[
  Tout entier $n in ZZ$ s'écrit de la forme :
  $
    n = +- product_(i = 1)^l p_i^(alpha_i)
  $

  où les $p_i$ sont des nombres premiers distincts et les $(alpha_i)$ sont des entiers non-nuls.

  La décomposition est unique à permutations près.
]

#definition("Valuation p-adique")[
  La valuation de $n in ZZ^*$ par rapport à $p in PP$ est l'entier maximal $alpha$ tel que $p^alpha divides n$, notée $v_p (n)$
]

#remark[
  On peut alors écrire tout nombre $n$ sous la forme :
  $
    n = +- product_(p in PP) p^(v_(p)(n))
  $
]

#property[
  + Si $a,b in ZZ^*$ et $a$ divise $b$, alors pour tout $p$ premier, $v_p (a) <= v_p (b)$
  + Si $a,b in ZZ^*$, $a and b = product_(p in PP) p^(min(v_p (a), v_p (b)))$
  + Si $a,b in ZZ^*$, $a or b = product_(p in PP) p^(max(v_p (a), v_p (b)))$
]

= $ZZ sur p ZZ$

#definition[
  On définit une relation binaire sur $ZZ$, une fois on fixe un entier $n in NN without {0,1}$ telle que :
  $ forall a,b in ZZ : a ~ b <==> n divides b-a $
]
#remark[
  C'est une relation d'équivalence
]

#definition[
  On pose $ZZ sur n ZZ$ l'ensemble quotient, c'est-à-dire l'ensemble des classes d'équivalences de cette relation. On appelle une classe ce cette relation une #underline[classe de résidu] modulo $n$.
]

#definition[
  Un ensemble d'entiers est un système complet de résidu modulo $n$ si leurs classes forment exactement $ZZ sur n ZZ$
]

#example[
  ${0,1,2,...,n-1}$ est un système complet modulo $n$.
]

#property[
  Soient $n in NN without {0,1}$ et $a,b in ZZ$. Supposons que $a and n = 1$.

  Alors $a + b, 2a + b, 3a + b, ..., n a + b$ forment un système complet modulo $n$
]

#proof[
  Il suffit de montrer que $a + b,...,n a + b$ sont deux-à-deux distincts.

  Supposons que $i a + b equiv j a + b mod(n)$ avec $1 <= i < j <= n$

  Alors $i a + b equiv j a + b mod(n)$
  C'est-à-dire qu'il existe $k in ZZ$ tel que :
  $
    i a + b = j a + b + n k
  $

  Donc $(j-i) a = -k n$

  En particulier $a divides k n$. Comme $a,n$ sont premiers entre eux, par le lemme d'Euclide, $a divides k$. On peut écrire $k = a A$ avec $A in ZZ$.

  Donc : $j-i = - A n$. Contradiction car $1 <= j-i <= n-1$
]

#definition("Anneau")[
  Un anneau est un ensemble $A$ muni de deux lois internes $+, cdot$ telles que :
  + $+$ est associative et commutative
  + Il existe un neutre $e$ par $+$
  + Tout $x in A$ possède un inverse par $+$
  + $cdot$ est associative
  + Il existe un neutre $E$ par $cdot$
  + $cdot$ est distributive par rapport à $+$

]

#definition("Corps")[
  $(A,+,cdot)$ est un corps si c'est un anneau et :
  $ forall x in A without {e} exists y in A, x y = E $
]

#example[

  $(ZZ.+.cdot)$ est un anneau

  $(RR,+,cdot)$ est un corps

  $(CC,+,cdot)$ est un corps

  $(QQ,+,cdot)$ est un corps

  $(CCC^0([0,1]),+,cdot)$ est un anneau
]

#property[
  $(ZZ sur n ZZ,+,cdot)$ est un anneau
]
#proof[
  Bon vous etes pas des bebes c'est bon.
]

#definition[
  On note $(ZZ sur n ZZ)^*$ le sous-ensemble de $(ZZ sur n ZZ)$ formé par ses inversibles.
  $
    (ZZ sur n ZZ)^* = {x in (ZZ sur n ZZ) | exists y in ZZ sur n ZZ, x y = 1}
  $
]

#remark[
  Si $a,b in (ZZ sur n ZZ)^*$, alors $a^(-1),a b in (ZZ sur n ZZ)^*$

  et on a $(a b)^(-1) = b^(-1)a^(-1)$
]

#definition[
  La fonction d'Euler $phi : cases(n >= 2 &|-> |(ZZ sur NN ZZ)^*|, 1&|->1)$
]

#property[
  Pour tout $n >= 2$, $(ZZ sur n ZZ)^* = {bar(a) | a in ZZ, a and n = 1} = {a in [|0,n-1|] | a and n = 1}$
]

#proof[
  Supposons que $a in [|0,n-1|]$ satisfait $a and n = 1$

  Par théorème de Bézout, il existe $k,l in ZZ$ tel que $k a + n l = 1$

  Ainsi $k a = 1 mod(n)$ et $bar(a)^(-1) = bar(k)$

  Réciproquement supposons que $a in ZZ$ et il existe $b in ZZ$ tel que $bar(a)bar(b) = bar(1)$ dans $ZZ sur n ZZ$

  Donc $a b = 1 + n k$ pour un $k in ZZ$

  Si $d divides a$ et $d divides n$, alors $d divides a b - n k = 1$. Donc $a and n = 1$
]

#corollary[
  Si $p$ est premier, alors $(ZZ sur p ZZ,+,cdot)$ est un corps. Si $n$ n'est pas premier, alors $(ZZ sur m ZZ)$ n'est pas un corps.
]

#corollary[
  $phi(p) = p-1$ quand $p$ est premier

  $phi(n) < n-1$ quand $n$ n'est pas premier.
]

#proposition[
  Pour tout $n >= 1$, $n = sum_(d divides n) phi(d)$
]

#example[
  Si $p$ est premier, $p = phi(1) + phi(p) = 1 + (p - 1)$
]

#proof[
  $Card([|1,n|]) = sum_(d divides n) Card{a in [|1,n|], a and n = d}$
]

#lemma[
  On a une bijection entre $A = {a in [|1,n|], a and n = d}$ et $B = {b = [|1,n/d|] b and n/d = 1}$
]

#proof[
  Considérons $f : application(B, A, b, b d)$. Montrons que $f$ est bien définie.

  Si $b in B_i$, alors $b d in [|1,n|]$. Il faut vérifier que $b d and n = d$

  Comme $d divides b d, d divides n$. $d <= b d and n$

  Par théorème de Bezout, il existe $k,l in ZZ$ tel que $k b = l n/d = 1$

  Donc $k b d + l n = d$.

  Ainsi tout diviseur commun de $b d$ et $n$ divise $d$ et on a $b d and n <= d$.

  Donc $b d and n = d$

  Montrons que $f$ est une biection.

  Supposons que $b_1,b_2 in B$ sont tels que $f(b_1) = f(b_2)$. Alors $b_1 d = b_2 d <==> b_1 = b_2$

  Donc $f$ injective.

  Soit $x in A$. Alors $d divides X$ c'est-à-dire $x/d in B$.

  Il reste à mq $x/d and n/d = 1$.

  Si $x/d and n/d = m > 1$, alors $m d divides x, m d divides n$, contradiction.
]

#proof("De la proposition")[
  $
    n & = sum_(d divides n) Card({a in nint(1, n) | a and n = 1}) = sum_(d divides n) Card({b in nint(1, n/d), b and n/d = 1}) \
      & = sum_(d divides n) phi(n/d) = sum_(d divides n) phi(d)
  $
]

#theorem("d'Euler")[
  Soit $n >= 2$. Soit $x in (ZZ sur n ZZ)^*$.

  Alors $x^phi(n) = bar(1)$ dans $ZZ sur n ZZ$
]

#proof[
  On considère $M = product_(a in (ZZ sur n ZZ)^*) a$

  Remarquons que $f : application(ZZ sur n ZZ^*, ZZ sur n ZZ^*, a, x a)$ est une bijection avec $f^(-1) : application(ZZ sur m ZZ^*, ZZ sur n ZZ^*, a, x^(-1)a)$

  $
    M = product_(a in ZZ sur n ZZ^*) a = product_(a in ZZ sur n ZZ^*) f(a) = product_(a in ZZ sur n ZZ^*) (x a) = x^phi(n) product_(a in ZZ/n ZZ^*) a = x^phi(n)M
  $

  Comme $M in ZZ sur n ZZ$, $M$ est inversible et donc $bar(1) = x^phi(n)$
]

#theorem("Des restes chinois")[
  Supposons que $r_1,r_2,dots,r_l$ sont des entiers deux-à-deux premiers entre eux. Soient $a_1, dots, a_l in ZZ$.

  Alors $cases(x equiv a_1 mod(r_1), vdots, x equiv a_l mod(r_l))$ admet des solutions dans $ZZ$.

  La solution est unique modulo $product_(i = 1)^l r_l$
]

#proof[
  Posons $R = r_1 dots r_l$ et $R_i = R/r_i$

  Remarquons que $r_i and R_i = 1$, $r_j and R_i = r_j$ si $j != i$

  Il existe $M_i in ZZ$ tel que $R_i cdot M_i equiv 1 mod(r_i)$

  On considère $X = sum_(i = 1)^l a_i M_i R_i in ZZ$

  On a pour tout $i$ : $X equiv sum_(j = 1)^l a_j M_j R_j mod(r_i) equiv a_i M_i R_i mod(r_i) equiv a_i mod(r_i)$

  L'unicité est à démontrer en exo.

]

#method[
  Soit $
  (E) : cases(x equiv a_1 mod(N_1),vdots,x equiv a_n mod(N_n))
  $
  où les $N_k$ sont deux-à-deux premiers entre eux 
  - Pour tout $k in [|1,n|]$ :
    + poser $r_k = N_k$, $R_k = product_(i != k) N_i$
    + Trouver $M_k = R_k^(-1)$ modulo $r_k$
  
  - poser x = $sum_(k = 1)^n a_k R_k M_k mod(product_(k=1)^n N_k)$
]

= Théorie des corps fini

#example[
  Les $(ZZ sur p ZZ,+,cdot) = FF_p$ sont des corps finis
]

#definition[
  Soit $KK$ un corps, on définit le caractéristique de $KK$ comme l'entier $c > 0$ minimal tel que :
  $underbrace(1 + dots + 1,c "fois") = 0$ si $c$ existe

  sinon $0$ si $c$ n'existe pas. 
]

#example[
  $car(FF_p) = p$, $car(RR) = car(CC) = car(QQ) = 0$
]

#property[
  Soit $KK$ un corps. Alors $car(KK) = 0$ ou $car(KK)$ premier
]

#proof[
  Supposons par contradiction que $car(KK) = d k$ avec $d,k >= 1$

  On pose $a = underbrace(1 + dots + 1,d "fois")$

  avec $d < car(KK), a != 0$.

  On a $a cdot underbrace((1 + dots + 1),k "fois") = a + dots + a = underbrace(1 + dots + 1,d k "fois") = 0$

  Comme $a != 0$, $a$ a un inverse $a^(-1)$

  En multipliant des 2 côtés par $a^(-1)$, on trouve $underbrace(1 + dots + 1,k "fois") = a^(-1)a = 0$. Cela contredit la minimalité de $car(KK)$.
]

#definition[
  Soient $KK,L$ deux corps.

  Un morphisme de corps $f : KK -> L$ est une application qui satisfait :
  + $forall x,y in KK$, $f(x) + f(y) = f(x + y)$
  + $forall x,y in KK$, $f(x)f(y) = f(x)f(y)$
  + $f(0) = 0$, $f(1) = 1$

  On dit que c'est un isomorphisme si elle est bijective.
]

#example[
  
  $application(RR,CC,x,x)$, $application(CC,CC,z,bar(z))$ sont des morphismes de corps
]

#property[
  Si $KK$ est un corps de caractéristique $p != 0$, alors :

  $f : application(KK,KK,X,X^p)$ est un morphisme de corps injectif.

  Si en plus $KK$ est fini, alors c'est une bijection.
]

#proof[
  Soient $x,y in KK$

  $f(1) = 1^p = 1$

  $f( y) = x^p y^p = f(x)f(y)$

  $f(x + y) = (x+y)^p = sum_(i=0)^p binom(p,i)x^i y^(p-i) = x^p + y^p + sum_(i=1)^(p-1) binom(p,i) x^i y^(p-i)$.

  On a facilement $p divides binom(p,i)$ pour tout $i in nint(1,p-1)$, donc la somme est nulle.
  
  Ainsi $f(x + y) = x^p + y^p = f(x) + f(y)$, d'où le morphisme.
]

#corollary[
  Si $KK$ est fini de caractéristique $p$, alors $x |-> x^p$ est un morphisme bijectif.
]

#proof[
  $phi$ est injective car si $x,y in KK$ sont tels que $phi(x) = phi(y)$, $phi(x-y) = 0$

  Supposons par l'absurde que $x-y != 0$. Alors on peut trouver $(x-y)^(-1)$ tq : $phi(x-y) phi((x-y)^(-1)) = phi(1) = 1$

  Or $phi(x-y) = 0$. Contradiction, CQFD
]

#theorem[
  Soit $KK$ un corps. Il existe $LL$ un corps tel que :
  + $KK subset LL$
  + tout $P in LL[X]$ admet une racine dans $LL$
  + à morphisme près, il existe un unique plus petit corps $LL$ (au sens $subset$) vérifiant les propriétés précédentes.
]

#remark[
  Ce plus petit $LL$ s'appelle *clôture algébrique* de $KK$. Et on a : $car(KK) = car(LL)$
]

#property[
  Soit $KK$ un corps fini de caractéristique $p$. Alors $KK$ est un $FF_p$-espace vectoriel de dimension finie.
]

#corollary[
  Le cardinal d'un corps fini est une puissance de son caractéristique.
]

#theorem[
  Soit $p$ un nombre premier. Soit $n in NN^*$. Il existe un corps fini de cardinal $p$. Il est unique à isomorphisme près.
]

#proof[
  Considérons $LL$ une clôture algébrique de $FF_p$. Posons $q = p^n$ et $P(X) = X^q - X in FF_p [X] subset LL[X]$

  D'après la propriété de clôture algébrique, $p$ est scindé dans $LL$.

  On a $P prime(X) = q X^(q-1) - 1 = p^n X^(q-1)-1 = -1$ car $p = 0$ dans un corps de caractéristique $p$.

  On pose $KK = {"racines de "P}$ qui est de cardinal $q$. Montrons que c'est un corps.

  Soit $0,1 in KK$. Supposons $ x,y in KK$. Alors :
  $
  (x+y)^q = underbrace(((((x+y)^p)^dots))^p,p "fois") = underbrace(((((x^p+y^p)^p)^dots))^p,p-1 "fois") = ... = x^(p^n) + y^(p^n) = x^q + y^q
  $

  Comme $x,y in KK$, $x^q = x$ et $y^q = y$

  Donc $(x+y)^q = x+y in KK$

  On a $(x y)^q = x^q y^q = x y in KK$
]

#definition("Ordre d'un élément")[
  Soit $KK$ un corps de caractéristique $p$ de cardinal $q = p^n$

  Soit $a in KK^*$

  On définit $ord(a)$ l'ordre de $a$ comme le plus petit entier $k$ non-nul tel que $a^k = 1$ dans $KK$.
]

#remark[
  Celui-ci existe car $a^(q-1) = 1$ donc $ord(a) <= q-1$
]

#proposition[
  Avec les mêmes hypothèses, $ord(a) divides q-1$
]

#proposition[
  Si $a^k = 1$, alors $ord(a) divides k$
]

#proposition[
  Supposons que $a in KK^*, ord(a) = e in NN^*$

  Alors $X^e - 1 = (X-1)(X-a)...(X-a^(e-1)) = product_(i=0)^(e-1) X-a^i in KK[X] $
]

#proof[
  Pour tout $i in [|0,e-1|]$, $(a^i)^e = (a^e)^i = 1$ et $(a^i)$ est une racine de $X^e - 1$

  Si $i,j in [|0,e-1|]$, alors :

  $a^i = a^j <==> a^(j-i) = 1 <==> e divides j - i <==> j-i = 0 <==> j = i$

  Donc $1, a, dots, a^(e-1)$ sont les $e$ racines distinctes de $X^e - 1$
]

#proposition[
  $ord(a^i) = (i or e)/i <= e$
]

#proof[
  $(a^i)^k = 1 <==> e divides i k$

  $k$ est le plus petit entier tel que $(a^i)^k = 1$ 
  
  $<==>$

  $k$ est le plus petit entier tel que $i k$ est multiple de $e$

  $<==>$

  $k = (i or e)/i$
]

#proposition[
  Pour $e$ un ordre, $Card({"Racines de " X^e - 1}) = phi(e)$
]

#theorem[
  Soit $KK$ un corps fini de caractéristique $p$ et de cardinal $q$.

  Alors il existe $x in KK^*$ tel; que :
  $ KK = {0,1,x,dots,x^(q-2)} $
]

#definition[
  Une fonction arithmétique est une fonction de $NN^*$ dans $CC$
]

#remark[
  C'est une suite de nombres complexes.
]

#definition[
  Une fonction arithmétique $f : NN^* --> CC$ est multiplicative si pour tout $a,b in NN^*$ :
  $
  a and b = 1 ==> f(a b) = f(a)f(b)
  $

  Si cest vrai sans l'hypothèse $a and b = 1$, alors $f$ est dite complètement multiplicative.
]

#definition[
  Soient $f$ et $g$ des fonctions arithmétiques. Le produit de convolution de Dirichlet de $f$ et $g$ est $f convolve g$ défini par :
  $
  (f convolve g)(n) = sum_(d divides n) f(d) g(n/d) (= sum_(a,b in NN^*, a b) f(a)g(b))
  $
]

#proposition[
  - $f convolve g = g convolve f$ et $f convolve (g convolve h) = (f convolve g) convolve h$
  - $delta convolve f = f$ (avec $delta$ la fonction indicatrice de ${1}$ restreinte à $NN^*$)
  - $f convolve (g + h) = f convolve g + f convolve h$
]

#theorem[
  Si $f$ et $g$ sont multiplicatives, alors $f convolve g$ l'est aussi
]
#proof[
  Considérons 
  $
  phi : application({(d_1,d_2) \\ d_1 divides n and d_2 divides m},{d in NN | d divides n m},(d_1\,d_2),d_1 d_2)
  $
  où  $m$ et $n$ sont des entiers fixés premiers entre eux.

  + $f$ est bien définie
  + Montrons que $f$ est injective :
    
    Soit $d$ tel que $ d divides n m$. Alors :
    - Soit $p$ est un diviseur premier de $d$
    - Soit $p divides n$ et $p divides m$
    Les 2 possibilités étant exclusives, on peut écrire : $d = product_(p_i divides n)p_i^(alpha_i) product_(q_j divides m) q_j^(beta_j)$

    Ainsi :
    $
    d = phi(product_(p_i divides n) p_i^(alpha_i),product_(q_j divides m) q_j^(beta_j))
    $
  + Supposons que $phi(d_1,d_2) = phi(e_1,e_2)$
    Alors $d_1 d_2 = e_1 e_2$

    Comme $d_1 divides e_1 e_2$ et $d_1 and e_2 = 1$ car $n and m = 1$, on a $d_1 divides e_2$ (lemme d'Euclide)

    De même, $e_1 divides d_1$ donc $d_1 = e_1$ et $d_2 = e_2$

  Ainsi : 
  $
  f convolve g(n m) &= sum_(d divides n m) f(d) g((n m)/d) = sum_(d_1 divides n, d_2 divides m) f(d_1 d_2)g((n m)/(d_1 d_2)) \
  &= sum_(d_1 divides n, d_2 divides m) f(d_1)f(d_2)g(n/d_1)g(m/d_2) = (sum_(d_1 divides n) f(d_1)g(n/d_1))(sum_(d_2 divides m) f(d_2)g(m/d_2)) \
  &= (f convolve g(n))(f convolve g(m))
  $
]

#theorem[
  Fixons $alpha >= 0$

  La fonction suivante est multiplicative :
  $sigma_alpha : application(NN^*,CC,n,sum_(d divides n) d^alpha)$
]

#property[
  $sigma_0 = $ "le nombre de diviseurs de $n$"
  
  $sigma_1 = $ "la somme des diviseurs de $n$"
]

#proof[
  Soient $n,m in NN^*$ tels que $m and n = 1$

  Alors :

  $sigma_alpha (n m) = sum_(d divides n m) d^alpha = sum_(d_1 divides n, d_2 divides m) d_1^alpha d_2^alpha = (sum_(d_1 divides n) d_1^alpha)(sum_(d_2 divides m) d_2^alpha)$
]

#theorem[
  Soit $f$ une fonction arithmétique telle que $f(1) != 0$

  Alors il existe une fonction arithmétique $g$ telle que $f convolve g = delta$
]
_Autrement dit, l'inverse de $f$ par la convolution existe toujours_

#remark("Rappel")[
  $delta(n) = cases(1 "si" n = 1, 0 "si" n > 1) = bb(1)_({1})$
]

#proof[
  On construit $g(n)$ par récurrence sur $n$, on pose $g(1) = 1/f(1)$, ainsi $(f convolve g)(1) = f(1)g(1/1) = delta(1)$

  Supposons que $g(1),dots,g(k)$ soient construits pour $k >= 1$. Il faut que :

  $
  0 = delta(k+1) = (f convolve g)(k + 1) = sum_(d divides k+1) f(d) g((k+1)/d) = f(1)g(k+1) + sum(d divides k+1 \ d!= 1) f(d)g((k+1)/d)
  $

  On peut choisir $g(k+1)$ de sorte que cette équation soit vraie.
]

#theorem[
  Supposons que $f : NN^* --> CC$ est multiplicative.

  Alors $f*^(-1)$, l'inverse par la convolution, est aussi multiplicative.
]

#proof[
  Soient $p$ premier, $alpha in NN^*$.

  On construit par récurrence les valeurs $g(p^(alpha))$ où $g$ est sensé être $f*^(-1)$

  - Pour $alpha = 1$ :
    $f(p)g(1) + g(p)f(1) = (f convolve g)(p) = delta(p) = 0$

    Ce qui nécessite que :
    $
    g(p) = (f(p)g(1))/(-f(1)) = -(f(p))/f(1)^2
    $

    Supposons que $g(p),dots,g(p^beta)$ soient contruits.

    Il faut que $0 = (f convolve g)(p^(beta+1)) = sum_(i=0)^(p+1) f(p^i)g(p^(beta+1-i)) = f(1)g(p^(beta+1))+sum_(i=1)^(beta+1)f(p^i)g(p^(beta+1-i))$. Il y a une unique solution pour $g(p^(beta+1))$.

    Si $n = product_(i) p_i^(alpha_i)$, alors on pose $g(n) = product_i g(p_i^(alpha_i))$ et on a bien $g$ multiplicative.
]

#exercice[
  Vérifier que $f convolve g = delta$ ("facile").
]

#theorem[
  La fonction d'Euler est multiplicative.
]

#proof[
  On a : $forall n in NN^*$, $n = sum_(d divides n) phi(d)$

  C'est-à-dire : $Id = bb(1) convolve phi$ (avec $bb(1) : n |-> 1$)

  D'après le théorème, $bb(1)$ admet un inverse $mu$ multiplicative.

  Donc $mu convolve Id = mu convolve bb(1) convolve phi = delta convolve phi = phi$ et $phi$ est multiplicative.
]

#remark[
  $mu$ est la "fonction de Moebius" et est définie comme :

  $ mu(n) = cases(0 "   "&"si" n "est divisible par un carré parfait" != 1,1 &"si" n "est le produit d'un nombre pair de premiers distincts",-1 &"si" n "est le produit d'un nombre impair de premiers distincts") $
]

= 

#underline[*Motivations :*]

Plaçons-nous dans $ZZ\/p ZZ$ avec $p >= 3$. On cherche les racines d'un polynôme dans cet espace. Si le polynôme est de degré $2$, facile :
$
X^2 + b X + c = 0 <==> (X + b/2)^2 - b^2/4 + c = 0 <==> (X+b/2)^2 = (b^2 - 4 c)/4
$

Pour les degrés plus élevés, c'est dur.

Le problème est réduit à comprendre les éléments de $ZZ\/ p ZZ$ qui s'écrivent comme des carrés.

#definition("Symbole de Legendre")[
  Soit $p >= 3$ premier. Soit $delta in ZZ \/ p ZZ$, ou $delta in ZZ$

  On définit :
  $
  (delta/p) = cases(1 quad &"si" exists b in ZZ\/p ZZ "tq" b^2 = delta, -1 &"si" forall b in ZZ \/ p ZZ "tq" b^2 != delta,0 &"si" delta =  0)
  $
]

#proposition[
  $abs({delta in (ZZ\/ p ZZ)^* | (delta/p) = 1}) = (p-1)/2$
]

#proposition[
  - Si $(delta/p) = 1$ :
    - Si $(b/p) = 1$, alors $((delta b)/p) = 1 quad (1)$
      
      #v(.5em)
    - Si $(b/p) = -1$, alors $((delta b)/p) = -1 quad (2)$
  - Si $(delta/p) = -1$ :
    - Si $(b/p) = -1$, alors $((delta b)/p) = 1 quad (3)$
]

#proof[

  Si $delta = u^2$, $b = v^2$, alors $delta b = (u v)^2$

  Supposons que $(b/p) = -1$

  Considérons $phi : application((ZZ\/ p ZZ)^*,(ZZ\/ p ZZ)^*,x,x b)$

  $phi$ est bijective car elle admet une fonction réciproque.


  Supposons que $x = u^2$, $x b = v^2$

  Alors $b = x b x^(-1) = (v u^(-1))^2$, contradiction. Cela démontre $(2)$

  $phi$ est une bijection et envoie chaque carré à un non-carré.

  En plus, on sait qu'il y a autant de carrés que de non-carrés. Donc $phi$ introduit une bijection des carrés vers les non-carrés, donc son complémentaire qui envoie les non-carrés aux carrés est aussi une bijection.

  $phi$ est un morphisme de groupe de $(ZZ\/ p ZZ)^*$ à ${-1,1}$

]

#lemma("d'Euler")[
  $(delta/p) = delta^((p-1)/2)$ dans $ZZ\/p ZZ$
]

#proof[
  À faire
]

#proposition[
  $(2/p) = cases(1 quad &"si" p = +- 1 mod(8),-1 &"si" p = +- 3 mod(8))$
]

#proof[

  $
  product_(1<=m<=p-1 \ 2 divides m) m = product_(j=1)^(p-1)/2 (2j) = 2^((p-1)/2) ((p-1)/2)! quad (*)
  $

  $
  product_((p-1)/2 < m <= p-1 \ 2 divides m) m = (-1)^(j_0) product (p-m) = (-1)^(j_0) product_(n <- (p-1)/2 \ 2 divides.not n) n
  $

  où $j_0 = floor((p-1)/2)$

  Donc, en regroupant les autres :
  $
  product_(1<=m<=p-1 \ 2 divides m) = (product_(m <= p-1 \ 2 divides m) m)(product_((p-1)/2< m <= p-1 \ 2 divides m) m) = (-1)^(j_0) product_(m <= (p-1)/2 \ 2 divides m) m product_(m <= (p-1)/2 \ 2 divides.not m) m = (-1)^(j_0) ((p-1)/2) quad (**)
  $

  Donc $(2/p) = 2^((p-1)/2) = (-1)^(j_0)$ via $(*)$ et $(**)$
]

#theorem("De réciprocité quadratique de Gauss")[

Soient $p,q >= 3$ premiers.

Alors :
$
(p/q)(q/p) = (-1)^((p-1)/2 cdot (q-1)/2)
$
]

_"Cela établit une relation mystérieuse entre $ZZ\/p ZZ$ et $ZZ\/q ZZ$ qui n'ont (pour le moment) aucun lien entre eux"_

#corollary[
  $(3/p) = cases(1 quad &"si" p equiv +-1 mod(12),-1 quad&"si" p equiv +-5 mod(12))$
]

#proof[
  $
  (3/p) = (p/3)(-1)^((p-1)/2 cdot (3-1)/2) = (-1)^((p-1)/2)(p/3)
  $

  où $
  p/3 = cases(1 quad &"si" p equiv 1 mod(3),-1 &"si" p equiv -1 mod(3))
  $
]

#theorem[
  $(ZZ\/p ZZ)^* = E uniondisj -E$ où :
  - $E = {1,dots,(p-1)/2}$
  - $-E = {-1, dots, (p-1)/2} = {(p+1)/2,dots,p-1}$
  
  Si $S in E$ et $delta in (ZZ\/p ZZ)^*$, alors $S$ s'écrit $delta S = e_S (delta) cdot S_delta$ où $e_S (delta) = +- 1$ et $S_delta in E$
]

#lemma[
  On fixe $delta in (ZZ\/p ZZ)^*$.

  Alors : $application(E,E,S,S_delta)$ est une bijection
]

#proof[
  Il suffit de montrer que cette application est injective.

  Supposons que $S,S^' in E$ ont $delta S = e_S (delta) S_delta$ et $delta S^' = e_(S^')(delta)S^'_(delta)$

  Donc $S = delta^(-1)e_S (delta) S^' delta = delta^(-1)S^' delta$ ou $-delta^(-1)S^' delta = S^'$ ou $-S^'$

  Donc $S = S^'$
]

#lemma[
  Si $n in NN^*$ est impair, alors en écrivant $f(z) = e^(i 2pi z) - e^(-i 2pi z)$, on a :
  $
  f(n z)/f(z) = product_(k=1)^((n-1)/2) f(z+k/n)f(z-k/n)
  $
]

#lemma[
  Pour $p$ premier, $a in (ZZ\/p ZZ)^*$ :
  $
  product_(s in E) f((s a)/p) = (a/p) product_(s in E) f(s/p)
  $
]

=

#definition("Fonction Zeta de Riemann")[
  Pour tout $x > 1$, on définit la fonction $zeta$ comme :
  $
  zeta(x) = sum_(n=1)^(+infinity) 1/n^x
  $
]
#definition("Séries (génératrices) de Dirichlet")[
  Si $Phi$ est une fonction arithmétique multiplicative, on définit la série de Dirichlet associée $F(Phi)$ comme :
  $
  F(Phi)(x) = sum_(i=1)^infinity Phi(n)/n^x 
  $

  pour tout $x in NN^*$ tel que la série converge.
]

#definition[
  On note la fonction $pi : NN^* --> NN$ qui pour tout $x >= 1$, associe $Card({k in [|1,x|] | k "est premier"})$
]

#theorem("Des nombres premiers/de La Vallée Poussin")[
  On a :
  $
  lim_(x->+infinity) pi(x) ln(x)/x = 1 <==> pi(x) tilde_(x->+infinity) x/ln(x)
  $
]

#theorem[
  La série $sum_(p "premier")1/p$ diverge
]

#lemma[
  Pour deux fonctions arithmétiques $Phi,psi$ :
  $
  1/zeta(k) = sum_(n=1)^infinity mu(n)/n^k
  $
  où $mu$ est la fonction de Moebius.
]

#proposition("Formule d'Euler")[
  Pour tout $x$, on a :

  $
  zeta(x) = product_(p "premier") (sum_(k=0)^infinity p^(-k x)) = product_(p "premier") 1/(1-1/p^k)
  $
]

#lemma[
  Pour tout $p$ premier, on a :
  $
  sum_(k>=2) 1/(k p^(k x)) <= 1/(2p^k)
  $
]

#lemma[
  Pour tout $X > 1$ :

  $
  1/(X-1) <= zeta(x) <= X/(X-1)
  $
]