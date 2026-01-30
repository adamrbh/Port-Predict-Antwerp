# ⚓ Analyse et Prévision du Trafic - Port d'Anvers-Bruges (2019-2023)

L'objectif est d'analyser les flux logistiques du deuxième port d'Europe et de fournir un modèle de prévision opérationnel.

## 📈 Conclusions Clés
* **Saisonnalité Hebdomadaire :** Identification d'un cycle strict de 7 jours avec un pic d'activité du mardi au vendredi et un creux le dimanche.
* **Chocs Exogènes :** Impact significatif des grèves, des jours fériés et du prix du pétrole sur le tonnage global.
* **Modèle Additif :** Le test de Buys-Ballot a confirmé que la variabilité du trafic ne dépend pas du niveau moyen, validant l'utilisation d'un modèle additif.

## 🛠️ Méthodologie Statistique
1. **Exploration :** Lissage par moyenne mobile (7 jours) pour extraire la tendance du bruit quotidien.
2. **Décomposition STL :** Séparation du signal en composantes Tendance, Saisonnalité (hebdomadaire) et Résidus (chocs ponctuels).
3. **Modélisation :** Régression linéaire multiple intégrant des variables économiques et calendaires.


## 💻 Stack Technique
* **Langage :** R
* **Bibliothèques principales :** `fpp2`, `zoo`, `ggplot2`.
* **Algorithmes :** Régression Linéaire (tslm), Décomposition STL.

## 📊 Résultats du Modèle
Le modèle de régression développé permet d'anticiper la charge de travail à **30 jours**. 
* **Précision :** La réalité observée reste dans l'intervalle de confiance du modèle.
* **Application :** Recommandation d'optimisation des effectifs RH en milieu de semaine.

---
**Auteurs :** Adam  & Wahil  
