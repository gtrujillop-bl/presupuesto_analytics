# Documentación
## Web de Presupuestos - Uniremington
### *Vicerrectoría de Investigaciones*


Este proyecto es un MVP (Producto Mínimo Viable) resulante del trabajo hecho durante las 96 horas de prácticas del estudiante del máster en Big Data y Visual Analytics de la UNIR, Gastón Trujillo Pulgar. Es básicamente una interfaz web dónde se puede gestionar los datos de presupuestos en la vicerrectoría de investigaciones. Mediate esta interfaz es posible:

- Cargar presupuestos mediante CSV
- Gestionar entidades (Proyecto, Investigador, Facultad, etc...)
- Ver gráficos para tener una 'vista' actual del estado de presupuestos (Valor Inicial, Egreso, Reserva, Disponibilidad) por entidad (Proyecto, Facultad, Grupo de Investigación, Año)

## Detalles de la documentación:

Este proyecto fué desarrollado netamente con software libre. De igual manera, su licencia es MIT (Ver el archivo LICENSE). La universidad podrá disponder del mismo (clonarlo, reproducirlo, hacerlo privativo) sin limitaciones, dándo crédito al autor.

* Ruby version
  * Utiliza Ruby 2.7.3  y rails 6.1.3

* Dependencias
  * PostgreSQL 12.7
  * Docker/Docker Compose
  * NodeJS 15.13.0
  * Yarn
  * Webpacker
  * RVM (Ruby Version Manager)
  * ChartJS 2.9.1
  * Sistema operativo GNU/Linux (Preferiblemente Ubuntu) si no se va a utilizar Docker

* Configuración con Docker
  *  Tener Docker instalado y funcionando https://docs.docker.com/get-docker/
  *  Entrar al proyecto y correr
     *  `docker-compose build && docker-compose up`
        *  El comando anterior instalará las dependencias de manera automática, luego creará las imágenes de docker para cada componente y finalmente correrá la aplicación en el ambiente DEV
     *  Entrar a http://localhost:3010/presupuestos
  
* Configuración convencional (Rails local en Ubuntu)
  * Instalar RVM https://rvm.io/rvm/install
  * Instalar y correr el server de Postgres 12.7
  * Instalar librerías (nodejs, etc.)
  * Con RVM instalar ruby 2.7.3 `rvm install 2.7.3`
  * Correr `gem install bundler`
  * Correr `bundle install`
  * Configurar la Base de Datos
    * Configurar las variables de entorno agregándolas al final del archivo `/etc/profile` ya que el archivo `database.yml` depende de las mismas
      * export POSTGRES_USER='uniremington_user'
      * export POSTGRES_PASSWORD='admin'
      * export DATABASE_HOST='127.0.0.1'
      * export POSTGRES_PORT='5433'
    * Correr `bundle exec rake db:create` y luego `rake db:schema:load`
  * Correr el servidor con `bundle exec rails s -p3010`


## Uso de la aplicación

### Lista de Presupuestos
![Selection_289](https://user-images.githubusercontent.com/4950300/121256277-fc9ded00-c871-11eb-9bb6-eeee5b9daf26.png)

### Vistas generales (e.j. Por Facultad)
![Selection_290](https://user-images.githubusercontent.com/4950300/121256443-2e16b880-c872-11eb-8f5a-3b9555537bcb.png)

![Selection_291](https://user-images.githubusercontent.com/4950300/121256494-3cfd6b00-c872-11eb-9470-2ddcc4bbf527.png)




