# Dotfiles

# NO TERMINADO, FALTA SERVICIOS CON DOCKER, ZSH CON PLUGINS

**Idioma**
- Español 🇪🇸
- [English 🇬🇧](./README.md)

# Descripción general
Lista de timezone's -> https://en.wikipedia.org/wiki/List_of_tz_database_time_zones

Configuración de entorno de escritorio totalmente automatizado. Preferible ejecutarlo en una instalación nueva de un SO. **Debería funcionar en cualquier distro con el gestor de paquetes `apt`**.

Probado en:
- Raspberry pi 5 64 bits

# Índice
- [Instalación](#instalación)
- [Terminal](#terminal)
- [Ficheros de configuración](#archivos-de-configuración)

# Instalación
```bash
# Clonar el repositorio
git clone https://github.com/Iortxi/dotfiles.git

# Moverse al directorio
cd dotfiles

# NO ejecutar con sudo, necesita un usuario. Igualmente da error si lo haces :D
./entorno.sh
```


# Terminal
Para poder usar varias terminales en una sola sesión (ventana) y al **no** poder usar `kitty`, se usa `tmux`.

## Atajos tmux
Se cambia el prefijo por defecto (Ctrl+b) por **`Ctrl+x`**.
| Tecla                     | Acción                                        |
|---------------------------|-----------------------------------------------|
| Prefijo + Return          | Shell en la misma ventana (pantalla dividida) |
| Prefijo + Up              | Foco arriba                                   |
| Prefijo + Down            | Foco abajo                                    |
| Prefijo + Right           | Foco derecha                                  |
| Prefijo + Left            | Foco izquierda                                |
| Prefijo + t               | Nueva pestaña                                 |
| Prefijo + Tab             | Cambiar pestañas                              |
| Prefijo + q               | Cerrar pestaña                                |
| Prefijo + Alt + t         | Renombrar pestaña                             |
| Ctrl + Supr               | Borrar palabra siguiente                      |
| Ctrl + Right              | Ir a palabra siguiente                        |
| Ctrl + Left               | Ir a palabra anterior                         |
| F1                        | Copiar al buffer 1                            |
| F2                        | Pegar del buffer 1                            |
| F3                        | Copiar al buffer 2                            |
| F4                        | Pegar del buffer 2                            |

## Ficheros de configuración
- `/etc/minidlna.conf` para el servicio MiniDLNA
- `/etc/proxychains.conf` para las cadenas de *proxyies*. A veces viene por defecto `/etc/proxychains4.conf`
- `~/.tmux.conf` para atajos de tmux
