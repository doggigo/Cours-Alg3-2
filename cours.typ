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
  En pratique, $a_n = $ la solution d'un problème de comptage qui dépend de $n$.
]

#example[
  Si $a_n$ est le nombre de moyens d'obtenir $n$ en lançant un dé
  $ a_n = cases(1 quad &"si" n in [|1,6|],0 "sinon") $

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

  Supposons que l'on ait $cases(6 "pièces de" 1 euro,1 "billet de " 5 euro,2 "pièces de "10 euro)$

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
  f(X) = &a_0 + &a_1 X + &a_2 X^2 + ... \
  X f(X) = &0 + &a_0 X + &a_1 X^2 + ... \
  X^2 f(X) = &0 + &0 + &a_0 X^2 + ... \
  $

  Ainsi :
  $
  X f(X) + X^2 f(X) = 0 + a_0 X + (a_0 + a_1)X^2 + (a_1 + a_2)X^3 + ... + (a_(n-1) + a_(n-2))X^n + ...
  $

  Donc $
  X f(X) + X^2f(X) = 0 + a_0 X + sum_(n = 2)^(infinity) a_n X^n = a_0 - X - a_0 - a_1 X + f(X)
  $

  Par convention $a_0 = 1, a_1 = 1$

  Donc au final, on a :
  $(X + X^2)f(X) = f(X) - 1 <==> f(X) = 1/(1 - X - X^2)$

  on peut décomposer en éléments simples.

  les racines du polynôme au dénominateur sont $phi,psi = (1 +- sqrt(5))/2$

  et on trouve ainsi $f(X) = 1/sqrt(5) [(phi)/(1-(1/phi) X) - (psi)/(1-(1/psi) X)]$ 

  En développant en série enière :
  $
  f(X) &= sum_(n = 0)^(infinity)[1/sqrt(5) phi (1/phi)^n - 1/sqrt(5) psi (1/psi)^n]X^n \
  &= sum_(n=0)^(infinity) (phi^(1-n)-psi^(1-n))/sqrt(5)X^n
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

  Ainsi $
  C_j &= sum_(k = 2)^(j+1)C_(k-2)C_(j-k+1) 
  = sum_(k=0)^(j-1) C_k C_(j-k-1) \
  &= sum_(k+l = j-1) C_k C_l

  $


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

  On utilise $(1+X)^(1/2) = sum_(n = 0)^(infinity) binom(1/2,n)X^n = sum_(n=0)^(infinity) (1/2 (1/2 - 1) ... (1/2 - (n-1)))/n! X^n$

  ainsi en l'évaluant en $-4X$ , on obtient :
  $sqrt(1-4X) = sum_(n=0)^(infinity) 2^n/n! (-1) ... (2n-3)...3cdot 1 cdot X^n$

  avec ça, on peut retrouver la série entière représentant $f$ et donc $C_j$ pour tout $j$. Finalement :
  $
  C_j = (2^j j! (2j -1) ...1)/((j+1)! j!)
  $

  Comme $2^j j! = 2 cdot 4 cdot 2j$, on a $
  C_j = ((2j)!)/((j+1)! j!) = ((2j)!)/((j!)^2(j+1))
  $
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