<%@ page import="maternidad.DetalleCaja" %>



<div class="fieldcontain ${hasErrors(bean: detalleCajaInstance, field: 'fecha', 'error')} required">
	<label for="fecha">
		<g:message code="detalleCaja.fecha.label" default="Fecha" />
	</label>
	<g:formatDate type="datetime" style="LONG" timeStyle="SHORT" readonly="readonly"   name="fecha"  value="${detalleCajaInstance?.fecha}"  />

</div>

<div class="fieldcontain ${hasErrors(bean: detalleCajaInstance, field: 'planillainternacion', 'error')} ">
	<label for="planillainternacion">
		<g:message code="detalleCaja.planillainternacion.label" default="Planillainternacion" />
		
	</label>
	<g:select id="planillainternacion" name="planillainternacion.id" from="${maternidad.PlanillaInternacion.list()}" optionKey="id" value="${detalleCajaInstance?.planillainternacion?.id}" class="many-to-one" noSelection="['null': '']"/>

</div>

<div class="fieldcontain ${hasErrors(bean: detalleCajaInstance, field: 'conceptocaja', 'error')} ">
	<label for="conceptocaja">
		<g:message code="detalleCaja.conceptocaja.label" default="Conceptocaja" />
		
	</label>
	<g:select id="conceptocaja" name="conceptocaja.id" from="${maternidad.ConceptoCaja.list()}" optionKey="id" value="${detalleCajaInstance?.conceptocaja?.id}" class="many-to-one" noSelection="['null': '']"/>

</div>

<div class="fieldcontain ${hasErrors(bean: detalleCajaInstance, field: 'credito', 'error')} ">
	<label for="credito">
		<g:message code="detalleCaja.credito.label" default="Credito" />
		(Crédito)
	</label>
	<g:checkBox  disabled="disabled"  name="credito" value="${detalleCajaInstance?.credito}" />

</div>

<div class="fieldcontain ${hasErrors(bean: detalleCajaInstance, field: 'monto', 'error')} required">
	<label for="monto">
		<g:message code="detalleCaja.monto.label" default="Monto" />
	</label>
    $ ${detalleCajaInstance?.monto?.encodeAsHTML()}
</div>

<div class="fieldcontain ${hasErrors(bean: detalleCajaInstance, field: 'observaciones', 'error')} ">
	<label for="observaciones">
		<g:message code="detalleCaja.observaciones.label" default="Observaciones" />
		
	</label>
	<g:textArea name="observaciones" cols="40" rows="5" maxlength="5000" value="${detalleCajaInstance?.observaciones}"/>

</div>

<div class="fieldcontain ${hasErrors(bean: detalleCajaInstance, field: 'usuario', 'error')} required">
	<label for="usuario">
		<g:message code="detalleCaja.usuario.label" default="Usuario" />
	</label>
    ${detalleCajaInstance?.usuario?.encodeAsHTML()}
</div>

<div class="fieldcontain ${hasErrors(bean: detalleCajaInstance, field: 'caja', 'error')} required">
	<!--
    <label for="caja" >
		<g:message code="detalleCaja.caja.label" default="Caja" />
		<span class="required-indicator">*</span>
	</label>
    -->
	<g:select id="caja" hidden="hidden" name="caja.id" from="${maternidad.CajaDiaria.findAllByFechaCierreIsNull()}" optionKey="id" required="" value="${detalleCajaInstance?.caja?.id}" class="many-to-one"/>

</div>

