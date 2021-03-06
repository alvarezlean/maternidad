package maternidad

class ConceptoLiquidacion {

    String observacion
    Boolean activo
    String nombre
    Boolean esMensual
    String codigo
    Boolean credito
    Double montoFijo
    Double porcentaje
    Boolean aplicaSobreBruto

    static constraints = {

        observacion(size:0..5000, nullable:true, blank:true)
        nombre(size:2..35, nullable:true, blank:true)
        codigo(size:2..10, nullable:true, blank:true)
        esMensual( nullable:true, blank:true)
        credito( nullable:false, blank:false)
        montoFijo( nullable:true, blank:true)
        porcentaje( nullable:true, blank:true)
        aplicaSobreBruto( nullable:true, blank:true)
    }
}
