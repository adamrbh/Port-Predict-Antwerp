#regarde tp1 et tp2 POUR LES BIBLIOTHQUEs
library(fpp2)
library(zoo)

# --- préparation des données ---

# on importe le fichier csv du port
df <- read.csv("data/antwerp_port_traffic.csv", encoding = "UTF-8", stringsAsFactors = FALSE)
df$date <- as.Date(df$date)

# création de la tendance et des objets temporels (fréquence 7 pour la semaine)
df$trend <- 1:nrow(df)
z_tonnage <- zoo(df$cargo_tonnage, order.by = df$date)
ts_tonnage <- ts(df$cargo_tonnage, frequency = 7)

df$lissage <- rollmean(z_tonnage, k = 7, fill = NA, align = "center")
autoplot(z_tonnage) +
  geom_line(color = "lightgrey") +
  geom_line(aes(y = df$lissage), color = "blue", size = 1) +
  theme_bw()

# matrice de corrélation pour vérifier la cohérence des données
vars_num <- df[, c("cargo_tonnage", "container_teu", "bulk_liquid", 
                   "vessel_arrivals", "oil_price", "baltic_index")]
round(cor(vars_num, use = "complete.obs"), 2)

# impact des jours fériés sur le tonnage (boxplot)
ggplot(df, aes(x = factor(holiday_be), y = cargo_tonnage, fill = factor(holiday_be))) +
  geom_boxplot() +
  scale_fill_manual(values = c("skyblue", "red"), labels = c("normal", "férié")) +
  theme_light()

# comparaison par type de marchandise (facettes)
ts_types <- ts(df[, c("container_teu", "bulk_liquid", "bulk_dry")], frequency = 7)
autoplot(ts_types, facets = TRUE) + theme_bw()

# --- partie 2 : saisonnalité et décomposition ---

# graphiques acf et lag plot pour valider le cycle de 7 jours
ggAcf(ts_tonnage, lag.max = 28) + theme_bw()
gglagplot(ts_tonnage, lags = 9, do.lines = FALSE) + theme_bw()

# analyse par jour de la semaine (sous-séries) pour voir les pics
ggsubseriesplot(ts_tonnage) + theme_minimal()

# --- analyse de buys-ballot ---

# on prépare les variables année et jour (saison)
df$annee <- format(df$date, "%Y")
df$jour <- weekdays(df$date)

# on calcule la moyenne (m) et l'écart-type (s) pour chaque groupe
# c'est le principe du tableau à double entrée vu en cours
stats_bb <- aggregate(cargo_tonnage ~ annee + jour, data = df, 
                      FUN = function(x) c(moyenne = mean(x), ecart_type = sd(x)))

# on transforme ça en dataframe propre
stats_bb <- data.frame(stats_bb$annee, stats_bb$jour, stats_bb$cargo_tonnage)
colnames(stats_bb) <- c("annee", "jour", "moyenne", "ecart_type")

# graphique de buys-ballot pour le choix du modèle
# on trace l'écart-type en fonction de la moyenne
ggplot(stats_bb, aes(x = moyenne, y = ecart_type)) +
  geom_point() +
  geom_smooth(method = "lm", se = FALSE, color = "red") +
  labs(title = "test de buys-ballot", x = "moyenne", y = "écart-type") +
  theme_bw()

# affichage des résultats numériques pour le rapport
print(stats_bb)

# décomposition stl pour séparer tendance et saisonnalité
fit_stl <- stl(ts_tonnage, s.window = "periodic")
autoplot(fit_stl) + theme_bw()

# check de la saisonnalité annuelle sur les moyennes mensuelles
df$mois_annee <- format(df$date, "%Y-%m")
monthly_data <- aggregate(cargo_tonnage ~ mois_annee, data = df, mean)
ts_monthly <- ts(monthly_data$cargo_tonnage, frequency = 12, start = c(2019, 1))
ggseasonplot(ts_monthly, year.labels = TRUE) + theme_bw()

# --- partie 3 : régression et prévisions ---

# on sépare les données on garde les 30 derniers jours pour tester
n <- length(ts_tonnage)
train_ts <- subset(ts_tonnage, end = n - 30)
test_ts  <- subset(ts_tonnage, start = n - 29)

# modèle de régression linéaire avec les variables du sujet (tendance, saison, pétrole, grèves)
fit_reg <- tslm(train_ts ~ trend + season + oil_price + strike + holiday_be, 
                data = df[1:(n-30), ])
summary(fit_reg)

# prévision sur le mois de test 
prevision <- forecast(fit_reg, newdata = df[(n-29):n, ])

# graphique final 
autoplot(prevision) +
  autolayer(test_ts, series = "réalité") +
  theme_bw()

# calcul de la précision du modèle
accuracy(prevision, test_ts)





