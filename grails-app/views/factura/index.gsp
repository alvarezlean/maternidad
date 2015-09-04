
<%@ page import="maternidad.Factura" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'factura.label', default: 'Factura')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>




	</head>
	<body>
		<a href="#list-factura" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
			<!--	<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li> -->
				<li><g:link class="create" action="facturar"><g:message code="facturacio.facturar"  /></g:link></li>
                <li><g:link class="create" controller="facturaPeriodo" action="abrirPagarFactura"><g:message code="default.new.pagoFactura" default="Pagar Facturas Por Obra Social" args="pagarFacturasPorObraSocial" /></g:link></li>
            </ul>

        </div>
		<div id="list-factura" class="content scaffold-list" role="main">
			<h1><g:message code="default.list.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
				<div class="message" role="status">${flash.message}</div>
			</g:if>

            <div class="filters">
                <g:form action="index">

                    <table >
                        <tr>
                            <td> <p><label for="nrofactura">Nº Factura</label>
                                <g:field type="number" only-num="" name="nrofactura" value="${filters?.nrofactura}" /></p></td>
                            <td>
                                <p><label for="plan">Plan</label>
                                    <g:select id="plan" name="plan" from="${maternidad.Plan.list()}" optionKey="id"  value="" noSelection="['':'']"/>
                                </p></td>
                    </tr>

                         <tr>
                            <td> <p><label for="fechaDesde">Desde</label>
                                <g:datePicker name="fechaDesde" precision="day"  value="${filters?.fechaDesde}" format="dd-MM-yyyy" /></p></td>
                            <td> <p><label for="fechaHasta">Hasta</label>
                                <g:datePicker name="fechaHasta" precision="day"  value="${filters?.fechaHasta}" format="dd-MM-yyyy" /></p></td>


                            <td>
                                <p><g:submitButton name="filter" value="Filtrar" /></p></td>
                        </tr>
                    </table>




                </g:form>
            </div>

            <br />
            <div id="grid">
                <g:render template="grilla" model="model" />
            </div>
            <br />


		</div>


    <script>
        $(function() {

            //idioma de los calendar
            jQuery.datepicker.regional[ "es" ];
            updateDatePicker();

            jQuery("#spinner").ajaxComplete(function (event, request, settings) {
                updateDatePicker();
            });

            jQuery("#plan").select2({allowClear: true,width: 'resolve'});


        })

    </script>

	</body>
</html>
