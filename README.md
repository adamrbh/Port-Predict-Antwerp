# ⚓ Analyse et Prévision du Trafic - Port d'Anvers-Bruges (2019-2023)

L'objectif est d'analyser les flux logistiques du deuxième port d'Europe et de fournir un modèle de prévision opérationnel.

## 📈 Conclusions Clés
* [cite_start]**Saisonnalité Hebdomadaire :** Identification d'un cycle strict de 7 jours avec un pic d'activité du mardi au vendredi et un creux le dimanche[cite: 23, 221].
* [cite_start]**Chocs Exogènes :** Impact significatif des grèves, des jours fériés et du prix du pétrole sur le tonnage global[cite: 25, 84].
* [cite_start]**Modèle Additif :** Le test de Buys-Ballot a confirmé que la variabilité du trafic ne dépend pas du niveau moyen, validant l'utilisation d'un modèle additif.

## 🛠️ Méthodologie Statistique
1. [cite_start]**Exploration :** Lissage par moyenne mobile (7 jours) pour extraire la tendance du bruit quotidien[cite: 68].
2. [cite_start]**Décomposition STL :** Séparation du signal en composantes Tendance, Saisonnalité (hebdomadaire) et Résidus (chocs ponctuels)[cite: 261, 289].
3. [cite_start]**Modélisation :** Régression linéaire multiple intégrant des variables économiques et calendaires[cite: 321, 342].


## 💻 Stack Technique
* **Langage :** R
* [cite_start]**Bibliothèques principales :** `fpp2`, `zoo`, `ggplot2`[cite: 375].
* **Algorithmes :** Régression Linéaire (tslm), Décomposition STL.

## 📊 Résultats du Modèle
Le modèle de régression développé permet d'anticiper la charge de travail à **30 jours**. 
* [cite_start]**Précision :** La réalité observée reste dans l'intervalle de confiance du modèle[cite: 356].
* [cite_start]**Application :** Recommandation d'optimisation des effectifs RH en milieu de semaine[cite: 365].

---
[cite_start]**Auteurs :** Adam RABBAH & Wahil TUZANI [cite: 7]
