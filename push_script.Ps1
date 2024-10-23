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
git push $GITHUB_REMOTE main
if ($LASTEXITCODE -eq 0) {
    Add-Content -Path $LOG_FILE -Value "Push réussi vers GitHub"
} else {
    Add-Content -Path $LOG_FILE -Value "Erreur lors du push vers GitHub"
}

# Pousser vers GitLab
git push $GITLAB_REMOTE main
if ($LASTEXITCODE -eq 0) {
    Add-Content -Path $LOG_FILE -Value "Push réussi vers GitLab"
} else {
    Add-Content -Path $LOG_FILE -Value "Erreur lors du push vers GitLab"
}

Add-Content -Path $LOG_FILE -Value ("{0} {1} - Fin du push" -f (Get-Date).ToShortDateString(), (Get-Date).ToLongTimeString())