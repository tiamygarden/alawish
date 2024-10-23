@echo off
setlocal

:: Définir les variables pour les remotes
set GITHUB_REMOTE=github
set GITLAB_REMOTE=gitlab
set LOG_FILE=push_log.txt

:: Date et heure pour le log
echo %date% %time% - Démarrage du push >> %LOG_FILE%

:: Ajouter tous les fichiers et effectuer un commit
git add .

:: Demander à l'utilisateur d'entrer un message de commit
set /p COMMIT_MESSAGE="Entrez le message de commit: "

:: Effectuer le commit avec le message fourni par l'utilisateur
git commit -m %COMMIT_MESSAGE%

:: Pousser vers GitHub
git push %GITHUB_REMOTE% main
if ERRORLEVEL 0 (
    echo Push réussi vers GitHub >> %LOG_FILE%
) else (
    echo Erreur lors du push vers GitHub >> %LOG_FILE%
)

:: Pousser vers GitLab
git push %GITLAB_REMOTE% main
if ERRORLEVEL 0 (
    echo Push réussi vers GitLab >> %LOG_FILE%
) else (
    echo Erreur lors du push vers GitLab >> %LOG_FILE%
)

echo %date% %time% - Fin du push >> %LOG_FILE%
endlocal