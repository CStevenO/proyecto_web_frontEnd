# proyecto_web_frontend

 Backend para una agencia de empleo, la  aplicación web permite administrar la información básica de los aspirantes a los cargos que se encuentra ofertados. Los aspirantes
son registrados por la agencia y se le asigna una oferta de empleo que se encuentre en la plataforma, además la agencia puede crear las ofertas para sus aspirantes y poder filtrar la información según lo requerido.

# API
## Spring Boot
 El servicio API Restfull se encuentra alojado en un servidor de Google Cloud y esta programada con Spring Boot. Para el manejo de la persistencia de datos se implementó la metodologia de Modelo-Repositorio-Servicio-Controlador.

 La documentación de la API se puede consultar en [API_SWAGGER](https://winged-quanta-337720.wl.r.appspot.com//swagger-ui.html#/)

 El proyecto se encuentra alojado en [API_REPOSITORIO](https://github.com/CStevenO/ProyectoWeb)

# Página Web
La página web se encuentra alojada en un servidor gratuito y esta programada completamente en Flutter - Dart. Para el manejo de la persistencia de datos se implementó la metodologia de MVC (Modelo-Vista-Controlador).

 El proyecto se encuentra alojado en [PaginaWebRepositorio](https://github.com/CStevenO/proyecto_web_frontEnd)
 
 ## Conexión
 En la carpeta controladores se encuentra la conexión a la API pero ya que posee información delicada se agrego al archivo .gitignore. Ese archivo contine la clase abstracta de Crud la cual es implementada por todos los archivos controller.gitignore
 
 
