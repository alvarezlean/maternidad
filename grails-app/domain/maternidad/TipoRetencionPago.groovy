package maternidad

class TipoRetencionPago {
    String codigo
    String descripcion

    static constraints = {
    }

    String toString() { "${descripcion}" }
}
