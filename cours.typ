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
  + $a | b c ==> a | c$
  + $a | c, b | c ==> a b | c$
]

#proof[
  + Supposons que $a | b c$

    Par le théorème de Bézout, on peut trouver $k,l in ZZ$ tels que $l a + l b = 1$

    Donc $c = c cdot 1 = c k a + c l b$

    Comme $a | c l b$ et $a | c k a$, on a $a | c$
  + Suppposons $a | c, b | c$. Alors posons $c = b k$, $k in NN$

    Par le $1)$, $a | k$. Donc $j = a l$ avec $l in NN$. Par conséquent $c = a b l$
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

  Comme $a | M$, on a $M = a k = d r k$ avec $k in NN$

  De même, on a $M = b l = d s l$ avec $l in NN$.

  On pose $P = M/d$. On a $P in NN$ car $d | M$

  On a $p = r k = s l$

  #underline[Remarque] : $a = d r, b = d s$. On a $r and s = 1$, car sinon $a and b > d$

  Comme $r k = P = s l$, on a $r | s l = P$

  D'après le lemme d'Euclide, $r | l$.

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
  La valuation de $n in ZZ^*$ par rapport à $p in PP$ est l'entier maximal $alpha$ tel que $p^alpha | n$, notée $v_p (n)$
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
  $ forall a,b in ZZ : a ~ b <==> n | b-a $
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

  En particulier $a | k n$. Comme $a,n$ sont premiers entre eux, par le lemme d'Euclide, $a | k$. On peut écrire $k = a A$ avec $A in ZZ$.

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

  Si $d | a$ et $d | n$, alors $d | a b - n k = 1$. Donc $a and n = 1$
]

#corollary[
  Si $p$ est premier, alors $(ZZ sur p ZZ,+,cdot)$ est un corps. Si $n$ n'est pas premier, alors $(ZZ sur m ZZ)$ n'est pas un corps.
]

#corollary[
  $phi(p) = p-1$ quand $p$ est premier

  $phi(n) < n-1$ quand $n$ n'est pas premier.
]

#proposition[
  Pour tout $n >= 1$, $n = sum_(d | n) phi(d)$
]

#example[
  Si $p$ est premier, $p = phi(1) + phi(p) = 1 + (p - 1)$
]

#proof[
  $Card([|1,n|]) = sum_(d | n) Card{a in [|1,n|], a and n = d}$
]

#lemma[
  On a une bijection entre $A = {a in [|1,n|], a and n = d}$ et $B = {b = [|1,n/d|] b and n/d = 1}$
]

#proof[
  Considérons $f : application(B, A, b, b d)$. Montrons que $f$ est bien définie.

  Si $b in B_i$, alors $b d in [|1,n|]$. Il faut vérifier que $b d and n = d$

  Comme $d | b d, d | n$. $d <= b d and n$

  Par théorème de Bezout, il existe $k,l in ZZ$ tel que $k b = l n/d = 1$

  Donc $k b d + l n = d$.

  Ainsi tout diviseur commun de $b d$ et $n$ divise $d$ et on a $b d and n <= d$.

  Donc $b d and n = d$

  Montrons que $f$ est une biection.

  Supposons que $b_1,b_2 in B$ sont tels que $f(b_1) = f(b_2)$. Alors $b_1 d = b_2 d <==> b_1 = b_2$

  Donc $f$ injective.

  Soit $x in A$. Alors $d | X$ c'est-à-dire $x/d in B$.

  Il reste à mq $x/d and n/d = 1$.

  Si $x/d and n/d = m > 1$, alors $m d | x, m d | n$, contradiction.
]

#proof("De la proposition")[
  $
    n & = sum_(d | n) Card({a in nint(1, n) | a and n = 1}) = sum_(d | n) Card({b in nint(1, n/d), b and n/d = 1}) \
      & = sum_(d | n) phi(n/d) = sum_(d | n) phi(d)
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

#example[
  Si $KK$ est un corps de caractéristique $p != 0$, alors :

  $f : application(KK,KK,X,X^p)$ est un morphisme de corps injectif.

  Si en plus $KK$ est fini, alors c'est une bijection.

  #underline[Démonstration] :

  Soient $x,y in KK$

  $f(1) = 1^p = 1$

  $f( y) = x^p y^p = f(x)f(y)$

  $f(x + y) = (x+y)^p = sum_(i=0)^p binom(p,i)x^i y^(p-i) = x^p + y^p + sum_(i=1)^(p-1) binom(p,i) x^i y^(p-i)$.

  On a facilement $p | binom(p,i)$ pour tout $i in nint(1,p-1)$, donc la somme est nulle.
  
  Ainsi $f(x + y) = x^p + y^p = f(x) + f(y)$, d'où le morphisme.
]
