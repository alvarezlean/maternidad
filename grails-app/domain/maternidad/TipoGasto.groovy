package maternidad

class TipoGasto {


    String sigla
    String descripcion

    static constraints = {

        sigla(nullable: false,blank: false)
        descripcion(nullable: true,blank: true)

    }

    String toString() { "${sigla+" - "+descripcion}" }

}
