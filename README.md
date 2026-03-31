# 🌋 Oath of the Volcano - Build System

This project includes an automated PowerShell script to package the game for **Unreal Engine 5.6**. 


Ce projet inclut un script PowerShell automatisé pour packager le jeu sous **Unreal Engine 5.6**.

---

## 🇬🇧 English: Manual Build Instructions

### 📋 Prerequisites
* **Unreal Engine 5.6** must be installed on the machine.
* **Disk Space:** Ensure at least **50GB** of free space on the local drive.
* **Visual Studio 2022/2025:** Required if the project contains C++ code.

### 🚀 How to Build
1. Navigate to: `.github/scripts/` inside the project folder.
2. Right-click the file `build.ps1` and select **"Run with PowerShell"**.
3. **If a security error appears (Execution Policy):**
   * Open a PowerShell window.
   * Type: `Set-ExecutionPolicy -ExecutionPolicy Bypass -Scope Process`
   * Drag the `build.ps1` file into that window and press **Enter**.
4. **Output:** Once finished, the packaged game will be zipped and placed in your **Downloads** folder.
---

## 🛠 Troubleshooting

| Issue | Solution |
| :--- | :--- |
| **"UE 5.6 not found"** | Edit `build.ps1` and update the `$UE_PATH` variable with the correct path to `RunUAT.bat`.|
| **"Disk Full"** | Ensure the build is running on a local SSD (C: or D:), not a network drive.|
| **"Cook Failed"** | Check the console logs for missing assets or shader errors.|

> **Note:** The build process can take between 15 to 60 minutes depending on the hardware. 

---

## 🇫🇷 Français : Instructions de Compilation

### 📋 Prérequis
* **Unreal Engine 5.6** doit être installé sur la machine.
* **Espace Disque :** Assurez-vous d'avoir au moins **50 Go** d'espace libre sur le disque local.
* **Visual Studio 2022/2025 :** Requis si le projet contient du code C++.

### 🚀 Comment compiler le projet
1. Allez dans le dossier : `.github/scripts/` à l'intérieur du projet.
2. Faites un clic droit sur le fichier `build.ps1` et sélectionnez **"Exécuter avec PowerShell"**.
3. **Si une erreur de sécurité s'affiche (Stratégie d'exécution) :**
   * Ouvrez une fenêtre PowerShell.
   * Tapez : `Set-ExecutionPolicy -ExecutionPolicy Bypass -Scope Process`
   * Glissez le fichier `build.ps1` dans la fenêtre et appuyez sur **Entrée**.
4. **Résultat :** Une fois terminé, le jeu sera compressé (.zip) et disponible dans votre dossier **Téléchargements**.

---

## 🛠 Troubleshooting / Dépannage

| Issue / Problème | Solution |
| :--- | :--- |
| **"UE 5.6 not found"** | Modifiez `build.ps1` et mettez à jour la variable `$UE_PATH` avec le chemin correct vers `RunUAT.bat`. |
| **"Disk Full"** | Assurez-vous que le build s'exécute sur un SSD local (C: ou D:), pas sur un lecteur réseau. |
| **"Cook Failed"** | Vérifiez les logs de la console pour des assets manquants ou des erreurs de shaders. |

---

> **Note :** Le processus de compilation peut prendre entre 15 et 60 minutes selon la puissance de la machine.
