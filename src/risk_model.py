import pandas as pd
from sklearn.linear_model import LogisticRegression
from sklearn.model_selection import train_test_split
from sklearn.metrics import classification_report

df = pd.read_csv("../data/transactions_50000.csv")

features = ["amount", "country_risk_score", "velocity_24h",
            "kyc_complete", "kyb_complete", "is_cross_border"]
X = df[features]
# Synthetic training target derived from high-risk operational signals.
y = (df["rule_alert"] | (df["model_probability"] >= 0.65)).astype(int)

X_train, X_test, y_train, y_test = train_test_split(
    X, y, test_size=0.2, random_state=42, stratify=y
)

model = LogisticRegression(max_iter=1000)
model.fit(X_train, y_train)
pred = model.predict(X_test)
print(classification_report(y_test, pred))
