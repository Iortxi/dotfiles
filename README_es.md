# Dotfiles

# NO TERMINADO
# PONER EL SOFTWARE QUE SE INSTALA (VLC, KCALC, ETC), DEPENDENCIAS DE PYTHON, ELEGIR NAVEGADORES, QUE SE AÑADE SUDO SIN PASSWORD

*Basado en [Antonio Sarosi dotfiles](https://github.com/antoniosarosi/dotfiles)*

**Idioma**
- Español 🇪🇸
- [English 🇬🇧](./README.md)

# Descripción general
Configuración de entorno de escritorio totalmente automatizada con múltiples gestores de ventanas.

**Preferible ejecutarlo en una instalación nueva del SO**. Debería funcionar en cualquier distro debian/ubuntu con apt.

Probado en:
- Kali Linux

# Índice
- [Instalación](#instalación)
- [Aplicaciones](#aplicaciones)
- [Gestores de ventanas](#gestores-de-ventanas)
    - [Qtile](#qtile)
    - [Spectrwm](#spectrwm)
- [Terminal](#terminal)
- [Monitores](#monitores)

# Instalación
```bash
# Clonar el repositorio
git clone https://github.com/Iortxi/dotfiles.git

# Moverse al directorio
cd dotfiles

# El teclado español está configurado, cámbialo si lo necesitas (US por defecto si lo eliminas)
nano .config/qtile/autostart.sh
nano .config/spectrwm/autostart.sh

# NO ejecutes con sudo, necesita tu usuario. Dará error si lo haces igualmente :D
# La flag -l es para portátiles, por si necesitas configurar batería y brillo
./entorno.sh [-l]
```

## Aplicaciones
Todos los gestores de ventanas tienen los mismos atajos para las aplicaciones.

| Tecla             | Acción                          |
|-------------------|---------------------------------|
| Mod + m           | Rofi                            |
| Mod + Shift + m   | Rofi con ventanas activas       |
| Mod + Return      | Terminal (Kitty)                |
| Mod + Space       | Google Chrome                   |
| Mod + e           | Explorador de archivos (Thunar) |
| Mod + o           | Obsidian                        |
| Mod + b           | Burpsuite                       |
| Mod + v           | Control de volumen (Pavucontrol)|
| Mod + k           | Calculadora (Kcalc)             |
| Mod + s           | Capturas (Flameshot)            |

# Gestores de ventanas
Estos son los gestores de ventanas configurados en estos dotfiles:
- [Qtile (recomendado)](#qtile)
- [Spectrwm](#spectrwm)

# Qtile
Gestor de ventanas hecho en Python (más bonito que Spectrwm :D). Hay 3 diseños configurados. Para añadir más, revisa la [documentación de layouts de Qtile](https://docs.qtile.org/en/latest/manual/ref/layouts.html).

*una foto de la barra con el fondo de pantalla y 3 más (una con cada layout)*

## Atajos
| Tecla             | Acción                    |
|-------------------|---------------------------|
| Mod + Up          | Enfocar ventana arriba    |
| Mod + Down        | Enfocar ventana abajo     |
| Mod + Right       | Enfocar ventana derecha   |
| Mod + Left        | Enfocar ventana izquierda |
| Mod + q           | Cerrar ventana            |
| Mod + alt + Up    | Agrandar ventana          |
| Mod + alt + Down  | Encoger ventana           |
| Mod + a           | Diseño Monadtall          |
| Mod + f           | Diseño Max                |
| Mod + c           | Diseño Monadwide          |
| Mod + Tab         | Siguiente ventana (Max)   |
| Mod + Comma       | Cambiar foco de monitor   |
| Mod + Ctrl + r    | Reiniciar Qtile           |
| Mod + Ctrl + q    | Salir de Qtile            |

## Scripts
Hay algunos scripts en Python hechos **específicamente** para Qtile con alias en [.bashrc](./shell/.bashrc).
### Theme
Cambiar los colores de la barra

### Interface
Cambiar la interfaz de red que se muestra en la barra

# Spectrwm
Gestor de ventanas hecho en C (el **no** recomendado D:). Menos estable que Qtile, da más problemas.

*foto*

## Scripts
También hay scripts en bash hechos **específicamente** para Spectrwm con alias en [.bashrc](./shell/.bashrc). Usan archivos en `~/.config/spectrwm/` para almacenar info (la que se muestra en la barra).
### Attack
Establece tu IP atacante en la barra

### Target
Establece la IP de tu víctima en la barra

# Terminal
Este entorno de escritorio usa kitty como terminal en todos los gestores de ventanas. No tan rápido como Alacritty pero muy útil para manejar múltiples shells en una sola ventana.

**PERFECTO** para evitar Tmux.

A veces cuando pegas texto, aparece un mensaje con 2 opciones (`Sanitize and paste` y `Paste anyway`). Elige `Paste anyway` presionando `p`.

## Atajos
| Tecla                     | Acción                                        |
|---------------------------|-----------------------------------------------|
| Mod + Return              | Lanzar kitty                                  |
| Ctrl + Shift + Return     | Shell en la misma ventana (pantalla dividida) |
| Ctrl + Alt + Up           | Foco arriba                                   |
| Ctrl + Alt + Down         | Foco abajo                                    |
| Ctrl + Alt + Right        | Foco derecha                                  |
| Ctrl + Alt + Left         | Foco izquierda                                |
| Ctrl + Shift + t          | Nueva pestaña                                 |
| Ctrl + Shift + Tab        | Cambiar pestañas                              |
| Ctrl + Shift + q          | Cerrar pestaña                                |
| Ctrl + Shift + Alt + t    | Renombrar pestaña                             |
| Ctrl + Shift + '+'        | Zoom in                                       |
| Ctrl + Shift + '-'        | Zoom out                                      |
| Ctrl + Supr               | Borrar palabra siguiente                      |
| Ctrl + Right              | Ir a palabra siguiente                        |
| Ctrl + Left               | Ir a palabra anterior                         |
| F1                        | Copiar al buffer 1                            |
| F2                        | Pegar del buffer 1                            |
| F3                        | Copiar al buffer 2                            |
| F4                        | Pegar del buffer 2                            |

## Archivos de configuración
- `~/.config/kitty/color.ini` para colores

- `~/.config/kitty/kitty` para atajos, fuente y shell.

# Monitores
Esto usa `arandr` para gestionar múltiples monitores.

Para automatizar:
1. Lanza arandr
2. Coloca las pantallas
3. Design -> Save as (genera un script)
4. Pon ese script en los autostart.sh
