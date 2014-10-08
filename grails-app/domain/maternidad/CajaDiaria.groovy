package maternidad

class CajaDiaria {
    Date fechaApertura
    Date fechaCierre
    Double saldoInicial = 0
    Double saldoFinal
    String observaciones
    Usuario usuarioApertura
    Usuario usuarioCierre

    static constraints = {
        fechaApertura(nullable: true,blank:true)
        fechaCierre(format:'dd-MM-yyyy',nullable: true,blank:true,attributes:[precision:"minute"],validator: { val, obj ->val?.after(obj.fechaApertura)})
        saldoInicial(nullable: false,blank: false,editable: false,scale: 2, matches: "[0-9]")
        saldoFinal(nullable: true,blank: true,editable: false,scale: 2, matches: "[0-9]")
        observaciones(size:0..5000,nullable: true,blank:true)
        usuarioApertura(nullable: true,blank: true, editable: false)
        usuarioCierre(nullable: true,blank: true,editable: false)
    }

    static hasMany = [
        detallesCaja: DetalleCaja
    ]

    String toString() { "Nº ${id}" }
}
