# Définir les variables pour les remotes
$GITHUB_REMOTE = "github"
$GITLAB_REMOTE = "gitlab"
$LOG_FILE = "push_log.txt"

# Date et heure pour le log
Add-Content -Path $LOG_FILE -Value ("{0} {1} - Démarrage du push" -f (Get-Date).ToShortDateString(), (Get-Date).ToLongTimeString())

# Ajouter tous les fichiers et effectuer un commit
git add .

# Demander à l'utilisateur d'entrer un message de commit
$COMMIT_MESSAGE = Read-Host -Prompt "Entrez le message de commit"

# Effectuer le commit avec le message fourni par l'utilisateur
git commit -m "$COMMIT_MESSAGE"

# Pousser vers GitHub
git checkout -b temp-github  # Créer une branche temporaire pour GitHub
git rm --cached .gitlab-ci.yml  # Retirer le fichier .gitlab-ci.yml de l'index
git commit -m "Retirer .gitlab-ci.yml pour le push vers GitHub"  # Commit des changements

git push $GITHUB_REMOTE temp-github:main  # Pousser vers GitHub

if ($LASTEXITCODE -eq 0) {
    Add-Content -Path $LOG_FILE -Value "Push réussi vers GitHub"
} else {
    Add-Content -Path $LOG_FILE -Value "Erreur lors du push vers GitHub"
}

# Revenir à la branche principale et supprimer la branche temporaire
git checkout main
git branch -D temp-github

# Pousser vers GitLab
git checkout -b temp-gitlab  # Créer une branche temporaire pour GitLab
git rm --cached .github  # Retirer le répertoire .github de l'index
git commit -m "Retirer .github pour le push vers GitLab"  # Commit des changements

git push $GITLAB_REMOTE temp-gitlab:main  # Pousser vers GitLab

if ($LASTEXITCODE -eq 0) {
    Add-Content -Path $LOG_FILE -Value "Push réussi vers GitLab"
} else {
    Add-Content -Path $LOG_FILE -Value "Erreur lors du push vers GitLab"
}

# Revenir à la branche principale et supprimer la branche temporaire
git checkout main
git branch -D temp-gitlab

Add-Content -Path $LOG_FILE -Value ("{0} {1} - Fin du push" -f (Get-Date).ToShortDateString(), (Get-Date).ToLongTimeString())