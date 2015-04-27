<%@ page import="maternidad.DetalleFactura" %>
<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main">
    <g:set var="entityName" value="${message(code: 'detalleFactura.label', default: 'DetalleFactura')}" />
    <title><g:message code="default.edit.label" args="[entityName]" /></title>
</head>
<body>
<a href="#edit-detalleFactura" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
%{--<div class="nav" role="navigation">--}%
%{--<ul>--}%
%{--<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>--}%
%{--<li><g:link class="list" action="index"><g:message code="default.list.label" args="[entityName]" /></g:link></li>--}%
%{--<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>--}%
%{--</ul>--}%
%{--</div>--}%
<div id="edit-detalleFactura" class="content scaffold-edit" role="main">
    <h1><g:message code="default.edit.label" args="[entityName]" /></h1>
    <g:if test="${flash.message}">
        <div class="message" role="status">${flash.message}</div>
    </g:if>
    <g:hasErrors bean="${detalleFacturaInstance}">
        <ul class="errors" role="alert">
            <g:eachError bean="${detalleFacturaInstance}" var="error">
                <li <g:if test="${error in org.springframework.validation.FieldError}">data-field-id="${error.field}"</g:if>><g:message error="${error}"/></li>
            </g:eachError>
        </ul>
    </g:hasErrors>
    <g:form url="[resource:detalleFacturaInstance, action:'updateDetalle']" method="PUT" >
        <g:hiddenField name="version" value="${detalleFacturaInstance?.version}" />
        <fieldset class="form">
            <g:render template="formEdit"/>
        </fieldset>
        <fieldset class="buttons">
            <g:actionSubmit class="save" action="updateDetalle" value="${message(code: 'default.button.update.label', default: 'Update')}" />
        </fieldset>
    </g:form>

<script>
    jQuery(function() {


        //idioma de los calendar
        jQuery.datepicker.regional[ "es" ];
        updateDatePicker();


        var valorHonorarios= jQuery("#valorHonorarios");
        var valorGastos= jQuery("#valorGastos");

        var divgasto= jQuery("#divgasto");
        var divhonorario= jQuery("#divhonorario");


        jQuery("#profesional").select2({allowClear: true});
        jQuery("#practica").select2({allowClear: true});


        var funcion="${detalleFacturaInstance.funcion}";


        jQuery('#funcion option[value="'+ funcion +'"]').attr("selected", "selected");














    })

</script>

</div>
</body>
</html>
