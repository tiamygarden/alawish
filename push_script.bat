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
if ERRORLEVEL 1 (
    echo Erreur lors de l'ajout des fichiers >> %LOG_FILE%
    exit /b 1
)

git commit -m "Mise à jour automatique par script batch"
if ERRORLEVEL 1 (
    echo Erreur lors du commit >> %LOG_FILE%
    exit /b 1
)

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