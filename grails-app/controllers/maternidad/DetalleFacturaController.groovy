package maternidad

import grails.converters.JSON
import grails.plugin.springsecurity.annotation.Secured

import static org.springframework.http.HttpStatus.*
import grails.transaction.Transactional

@Secured("hasAnyRole('ROLE_ADMIN','ROLE_USER')")
@Transactional(readOnly = true)
class DetalleFacturaController {

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def springSecurityService

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond DetalleFactura.list(params), model: [detalleFacturaInstanceCount: DetalleFactura.count()]
    }

    def show(DetalleFactura detalleFacturaInstance) {
        respond detalleFacturaInstance
    }

    def create() {
        respond new DetalleFactura(params)
    }

    @Transactional
    def save(DetalleFactura detalleFacturaInstance) {
        if (detalleFacturaInstance == null) {
            notFound()
            return
        }

        if (detalleFacturaInstance.hasErrors()) {
            respond detalleFacturaInstance.errors, view: 'create'
            return
        }

        detalleFacturaInstance.save flush: true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'detalleFactura.label', default: 'DetalleFactura'), detalleFacturaInstance.id])
                redirect detalleFacturaInstance
            }
            '*' { respond detalleFacturaInstance, [status: CREATED] }
        }
    }

    def edit(DetalleFactura detalleFacturaInstance) {
        respond detalleFacturaInstance
    }

    def editDetalle = {

        DetalleFactura detalleFacturaInstance = DetalleFactura.get(params.id)

        def planilla
        def valores


        planilla = detalleFacturaInstance.planillaInternacion

        def planConvenio = PlanConvenio.withCriteria {
            eq("plan", planilla?.plan)
            convenio {
                eq("activo", Boolean.TRUE)
            }
        }

        valores = ValorPractica.findAllByPlanConvenio(planConvenio)?.practica as List<Practica>

        return [detalleFacturaInstance: detalleFacturaInstance, practicas: valores]

    }

//    @Transactional
//    def update(DetalleFactura detalleFacturaInstance) {
//        if (detalleFacturaInstance == null) {
//            notFound()
//            return
//        }
//
//        if (detalleFacturaInstance.hasErrors()) {
//            respond detalleFacturaInstance.errors, view: 'edit'
//            return
//        }
//
//        detalleFacturaInstance.save flush: true
//
//        request.withFormat {
//            form multipartForm {
//                flash.message = message(code: 'default.updated.message', args: [message(code: 'DetalleFactura.label', default: 'DetalleFactura'), detalleFacturaInstance.id])
//                redirect detalleFacturaInstance
//            }
//            '*' { respond detalleFacturaInstance, [status: OK] }
//        }
//    }

    @Transactional
    def update() {
        def detalleFacturaInstance

        if (params.id) {
            detalleFacturaInstance = DetalleFactura.read(params.long('id'))
        }
        if (detalleFacturaInstance) {
            detalleFacturaInstance.valorHonorarios = params.double('valorHonorarios')
            detalleFacturaInstance.valorGastos = params.double('valorGastos')
            detalleFacturaInstance.cantidad = params.double('cantidad')
            if (params?.valorMedicamento) {
                detalleFacturaInstance.valorMedicamento = params.double('valorMedicamento')
            }

            if (detalleFacturaInstance.hasErrors()) {
                respond detalleFacturaInstance.errors, view: 'edit'
                return
            }

            if (detalleFacturaInstance.save(flush: true)) {

                def factura = Factura.findByPlanillaInternacion(detalleFacturaInstance?.planillaInternacion)

                redirect(controller: 'factura', action: 'show', params: [id: factura?.id])
            } else {
                respond detalleFacturaInstance.errors, view: 'edit'
                return
            }
        }

    }


    @Transactional
    def updateDetalle(DetalleFactura detalleFacturaInstance) {

        if (detalleFacturaInstance == null) {
            notFound()
            return
        }
        if (detalleFacturaInstance) {
            detalleFacturaInstance.valorHonorarios = params.double('valorHonorarios')
            detalleFacturaInstance.valorGastos = params.double('valorGastos')
            detalleFacturaInstance.cantidad = params.double('cantidad')
            if (params?.valorMedicamento) {
                detalleFacturaInstance.valorMedicamento = params.double('valorMedicamento')
            }

            if (detalleFacturaInstance.hasErrors()) {
                respond detalleFacturaInstance.errors, view: 'editDetalle'
                return
            }

            if (detalleFacturaInstance.save(flush: true)) {

                if (detalleFacturaInstance?.practica) {
                    redirect(action: 'cargaPracticas', params: [id: detalleFacturaInstance?.planillaInternacion?.id])
                } else {

                    redirect(action: 'cargaMedicamentos', params: [id: detalleFacturaInstance?.planillaInternacion?.id])

                }


            } else {
                respond detalleFacturaInstance.errors, view: 'editDetalle'
                return
            }
        }

    }


    @Transactional
    def delete(DetalleFactura detalleFacturaInstance) {

        if (detalleFacturaInstance == null) {
            notFound()
            return
        }

        detalleFacturaInstance.delete flush: true

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'DetalleFactura.label', default: 'DetalleFactura'), detalleFacturaInstance.id])
                redirect action: "index", method: "GET"
            }
            '*' { render status: NO_CONTENT }
        }
    }


    @Transactional
    def eliminarDetalle() {

        def detalleFacturaInstance = DetalleFactura.get(params.detalle as long)
        def planilla = params.planilla

        if (detalleFacturaInstance == null) {
            notFound()
            return
        }

        detalleFacturaInstance.delete flush: true

        if(params.pantalla=="practica"){
            redirect action: "cargaPracticas", params: [id: planilla]
        }
        else {
            redirect action: "cargaMedicamentos", params: [id: planilla]
        }


        /* request.withFormat {
             form multipartForm {
                 flash.message = message(code: 'default.deleted.message', args: [message(code: 'DetalleFactura.label', default: 'DetalleFactura'), detalleFacturaInstance.id])

             }
             '*' { render status: NO_CONTENT }
         } */
    }


    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'detalleFactura.label', default: 'DetalleFactura'), params.id])
                redirect action: "index", method: "GET"
            }
            '*' { respond view: 'cargaPracticas' }
        }
    }


    def cargaPracticas() {

        def planilla
        def valores
        def detalle = new DetalleFactura(params)
        def listaDetalles = []
        if (params.id) {
            planilla = PlanillaInternacion.get(params.id)
            detalle.planillaInternacion = planilla
            detalle.plan = planilla.plan
            def planConvenio = PlanConvenio.withCriteria {
                eq("plan", planilla?.plan)
                convenio {
                    eq("activo", Boolean.TRUE)
                }
            }

            valores = ValorPractica.findAllByPlanConvenio(planConvenio)?.practica as List<Practica>

            listaDetalles = DetalleFactura.createCriteria().list {
                createAlias('planillaInternacion', 'planilla')
                eq('planillaInternacion', planilla)
                isNull("planilla.factura")
                isNull("medicamento")
            }?.sort { -it.id }
            if (listaDetalles) detalle.fecha = listaDetalles.first()?.fecha

            if(params?.tieneErrores){
                if(params.practicaId) detalle.practica = Practica.read(params.long('practicaId'))
                if(params.profesionalId) detalle.profesional = Profesional.read(params.long('profesionalId'))
                if(params.funcion) detalle.funcion = params.int('funcion')
                detalle.validate()
                flash.error = params.error
            }

        }

        return [detalleFacturaInstance: detalle, practicas: valores, listaDetalles: listaDetalles]
    }


    def cargaMedicamentos() {

        def planilla
        def listaDetalles = []
        def detalle = new DetalleFactura(params)
        if (params.id) {
            planilla = PlanillaInternacion.get(params.id)
            detalle.planillaInternacion = planilla
            detalle.plan = planilla.plan
            listaDetalles = DetalleFactura.createCriteria().list {
                createAlias('planillaInternacion', 'planilla')
                eq('planillaInternacion', planilla)
                isNull("planilla.factura")
                isNotNull("medicamento")
            }?.sort { -it.id }
        }


        if(params?.tieneErrores){

            detalle.validate()
            flash.error = params.error
        }


        if (listaDetalles) detalle.fecha = listaDetalles.first()?.fecha
        return [detalleFacturaInstance: detalle, listaDetalles: listaDetalles]
    }


    @Transactional
    def saveCarga(DetalleFactura detalleFacturaInstance) {
        flash.error = null
        if (detalleFacturaInstance == null) {
            notFound()
            return
        }

        if (detalleFacturaInstance.practica.modulo) {
            detalleFacturaInstance.modulo = Boolean.TRUE
        }
        try {
            if (params?.fechaText && params?.date('fechaText', 'dd/MM/yyyy')) {
                detalleFacturaInstance.fecha = params?.date('fechaText', 'dd/MM/yyyy')
            } else {
                flash.error = "La fecha ingresada (${params?.fechaText}) no es válida"
            }
        } catch (e) {
            flash.error = "La fecha ingresada (${params?.fechaText}) no es válida"
        }
        detalleFacturaInstance.valorGastos = (params?.valorGastos) ? params?.valorGastos as Double : 0
        detalleFacturaInstance.valorHonorarios = (params?.valorHonorarios) ? params?.valorHonorarios as Double : 0
        detalleFacturaInstance.cantidad = (params?.cantidad) ? params?.cantidad as Double : 0

        if (flash.error || !detalleFacturaInstance.validate() || detalleFacturaInstance.hasErrors()) {
           redirect(action: "cargaPracticas", params: [tieneErrores: true, practicaId: detalleFacturaInstance?.practica?.id, funcion: detalleFacturaInstance?.funcion, profesionalId: detalleFacturaInstance.profesional?.id, id: detalleFacturaInstance.planillaInternacion.id, error: flash.error])

            return
        }

        detalleFacturaInstance.save flush: true


        if (detalleFacturaInstance.planillaInternacion.estadoPlanilla == EstadoPlanilla.findByNombre("INICIADA")) {
            detalleFacturaInstance.planillaInternacion.estadoPlanilla = EstadoPlanilla.findByNombre("EN PROCESO")
            detalleFacturaInstance.planillaInternacion.save(flush: true)

            def usuario = springSecurityService.currentUser
            def movimiento = new MovimientoPlanilla()
            movimiento.estadoPlanilla = detalleFacturaInstance.planillaInternacion.estadoPlanilla
            movimiento.fecha = new Date()
            movimiento.planillaInternacion = detalleFacturaInstance.planillaInternacion
            movimiento.usuario = usuario as Usuario
            movimiento.save(flush: true)
        }



        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'detalleFactura.label', default: 'DetalleFactura'), detalleFacturaInstance.id])
                redirect(action: "cargaPracticas", params: [id: detalleFacturaInstance?.planillaInternacion?.id])
            }
            '*' { respond detalleFacturaInstance, [status: CREATED] }
        }
    }


    @Transactional
    def saveCargaMedicamento(DetalleFactura detalleFacturaInstance) {
        flash.error = null

        if (detalleFacturaInstance == null) {
            notFound()
            return
        }

       /* if (detalleFacturaInstance.hasErrors()) {
            respond detalleFacturaInstance.errors, view: 'cargaMedicamentos',model: detalleFacturaInstance
            return
        }
        */

        detalleFacturaInstance.cantidad = (params?.cantidad) ? params?.cantidad as Double : 0
        detalleFacturaInstance.valorMedicamento = (params?.valorMedicamento) ? params?.valorMedicamento as Double : 0

        try {
            if (params?.fechaText && params?.date('fechaText', 'dd/MM/yyyy')) {
                detalleFacturaInstance.fecha = params?.date('fechaText', 'dd/MM/yyyy')
            } else {
                flash.error = "La fecha ingresada (${params?.fechaText}) no es válida"
            }
        } catch (e) {
            flash.error = "La fecha ingresada (${params?.fechaText}) no es válida"
        }


        if (flash.error || !detalleFacturaInstance.validate() || detalleFacturaInstance.hasErrors()) {
            redirect(action: "cargaMedicamentos", params: [tieneErrores: true, id: detalleFacturaInstance.planillaInternacion.id, error: flash.error])

            return
        }

        detalleFacturaInstance.save flush: true

        if (detalleFacturaInstance.planillaInternacion.estadoPlanilla == EstadoPlanilla.findByNombre("INICIADA")) {
            detalleFacturaInstance.planillaInternacion.estadoPlanilla = EstadoPlanilla.findByNombre("EN PROCESO")
            detalleFacturaInstance.planillaInternacion.save(flush: true)

            def usuario = springSecurityService.currentUser
            def movimiento = new MovimientoPlanilla()
            movimiento.estadoPlanilla = detalleFacturaInstance.planillaInternacion.estadoPlanilla
            movimiento.fecha = new Date()
            movimiento.planillaInternacion = detalleFacturaInstance.planillaInternacion
            movimiento.usuario = usuario as Usuario
            movimiento.save(flush: true)
        }

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'detalleFactura.label', default: 'DetalleFactura'), detalleFacturaInstance.id])
                redirect(action: "cargaMedicamentos", params: [id: detalleFacturaInstance?.planillaInternacion?.id])
            }
            '*' { respond detalleFacturaInstance, [status: CREATED] }
        }
    }


    def public obtenerValores() {

        /*  10 - honorarios    si tiene valor honorario tomar valorhon sino valor especialista
       20- ayudante
       30-anestecista
       60 - gasto
       70 - gasto y honorarios llenar los dos campos
       91 - libre carga valor honorario a mano  sacar el readonly y permitir cargar valor que se escribe en valor honorario */

        def honorario = 0
        def gasto = 0

        def plan = Plan.get(params.plan)
        def planConvenio = PlanConvenio.withCriteria {
            convenio { eq("activo", true) }
            eq("plan", plan)
        }
        def practica = Practica.get(params.practica)
        def funcion = params.funcion as Integer

        def valorPractica = ValorPractica.findByPlanConvenioAndPractica(planConvenio, practica)

        if (funcion == 10) {

            if (valorPractica?.valorHonorario) {
                honorario = valorPractica?.valorHonorario
            } else {
                honorario = valorPractica?.valorEspecialista
            }
        }

        if (funcion == 20) {
            honorario = valorPractica?.valorAyudante
        }

        if (funcion == 30) {
            honorario = valorPractica?.valorAnestecista
        }

        if (funcion == 60) {
            gasto = valorPractica?.valorGasto
        }

        if (funcion == 70) {
            gasto = valorPractica?.valorGasto

            if (valorPractica?.valorHonorario) {
                honorario = valorPractica?.valorHonorario
            } else {
                honorario = valorPractica?.valorEspecialista
            }
        }

//return plan as JSON
        render(contentType: 'text/json') {
            [
                    'gasto': Math.round(gasto * 100) / 100,
                    'honorario': Math.round(honorario * 100) / 100
            ]
        }
    }


    def public obtenerValorMedicamento() {


        def medicamento = Medicamento.get(params.medicamento)
        // def funcion= params.funcion as Integer

        render(contentType: 'text/json') {
            [
                    //'valor': (medicamento?.valor)?(Math.round(medicamento?.valor * 100) / 100):0
                    'valor': (medicamento?.valor) ? (medicamento?.valor) : 0
            ]
        }
    }


}
