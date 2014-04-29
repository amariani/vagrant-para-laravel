# Archivo Vagrant ideal para trabajar con Laravel4

Se trata de una configuración de Ubuntu 12.04 básica que contiene PHP 5.5, Apache, MySQL, git, composer, xDebug, phpMyAdmin
y otros que realice basándome en otras configuraciones, como por ejemplo la de Jeffrey Way y Bryan Nielsen y agregue algunas otras configuraciones que uso a diario.

## Requerimientos

* VirtualBox - Software de virtualización [Descargar Virtualbox](https://www.virtualbox.org/wiki/Downloads)
* Vagrant **1.3+** - Herramienta que sirve para trabajar con imágenes de virtualbox (boxes o cajas) [Descargar Vagrant](https://www.vagrantup.com)
* Git - Software de control de versiones [Descargar Git](http://git-scm.com/downloads)

## Instalación


* Esta configuración esta pensada para ser aplicada a un proyecto existente de Laravel, ya que esta instalación NO instala Laravel.
* Dentro del directorio de nuestra aplicación de Laravel debemos clonar este repositorio ejecutando lo siguiente `git clone https://github.com/amariani/vagrant-para-laravel.git .`
* Se descargaran dos archivos (instalador.sh y Vagrantfile).
* Con un editor de texto abre el archivo 'instalador.sh' y edita (si lo deseas) las variables allí establecidas.
* Ejecutar `vagrant up`
* (Si es la primera vez que ejecutas vagrant va a tardar algunos minutos ya que tiene que descargar una imagen de aproximadamente 300Mb, todo depende de tu velocidad de conexión).
* Vagrant va a usar el archivo 'instalador.sh' como 'provision' e instalara todos los paquetes que y configuraciones descriptas en ese archivo.
* Si todo salio bien, puedes testear tu aplicación Laravel en http://127.0.1.1/ o http://localhost o http://dominio.dev/ en tu navegador.


### Base de datos MySQL vía PHPmyAdmin

* Acceso: http://127.0.1.1/phpmyadmin o http://localhost/phpmyadmin o http://dominio.dev/phpmyadmin
* Usuario: root
* Password: root


### Comandos Vagrant

* `vagrant up` inicializa la máquina virtual
* `vagrant suspend` Pone la máquina virtual en modo 'sleep', con el comando `vagrant resume` se vuelve al modo anterior
* `vagrant halt` apaga la máquina virtual.
* `vagrant ssh` te da acceso a la máquina virtual, desde aquí correremos los comandos: php artisan, composer, etc.

Para mas comandos pueden chequear la [documentación](http://vagrantup.com/v1/docs/index.html).

### Como utilizar los comandos de Laravel

* Una vez que este todo funcionando, debemos acceder por SSH a la máquina virtual con `vagrant ssh`, una vez allí hacer lo siguiente:
* vagrant@precise32:~$ cd .. [ENTER]
* vagrant@precise32:/home$ cd .. [ENTER]
* vagrant@precise32:/$ cd vagrant [ENTER]
* vagrant@precise32:/vagrant$ php artisan [ENTER]

----
##### Especificaciones de la máquina Virtual #####

* OS     - Ubuntu 12.04
* Apache - 2.4.9
* PHP    - 5.5.4
* MySQL  - 5.5.37