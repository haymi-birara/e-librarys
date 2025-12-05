@echo off
set /p javafx_path="Enter the path to JavaFX SDK lib folder (e.g., C:\Program Files\Java\javafx-sdk-21\lib): "

if not exist "%javafx_path%" (
    echo Error: JavaFX lib folder not found at %javafx_path%
    pause
    exit /b 1
)

echo Copying JavaFX JAR files...
copy "%javafx_path%\javafx.base.jar" "lib\"
copy "%javafx_path%\javafx.controls.jar" "lib\"
copy "%javafx_path%\javafx.fxml.jar" "lib\"
copy "%javafx_path%\javafx.graphics.jar" "lib\"
copy "%javafx_path%\javafx.media.jar" "lib\"
copy "%javafx_path%\javafx.swing.jar" "lib\"
copy "%javafx_path%\javafx.web.jar" "lib\"

echo Done!
pause 