<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'detalleCaja.label', default: 'DetalleCaja')}" />
		<title><g:message code="default.create.label" args="[entityName]" /></title>
        <script>
            $(function() {
                //idioma de los calendar
                jQuery.datepicker.regional[ "es" ];
                updateDatePicker();
                jQuery("#spinner").ajaxComplete(function (event, request, settings) {
                    updateDatePicker();
                });
                //Selector para planilla de internacion
                $("#planillainternacion").select2({allowClear: true});
                //Selector para Concepto
                $("#conceptocaja").select2({allowClear: true});
            })
        </script>
	</head>
	<body>
		<a href="#create-detalleCaja" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="list" action="index"><g:message code="default.list.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="create-detalleCaja" class="content scaffold-create" role="main">
			<h1><g:message code="default.create.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<g:hasErrors bean="${detalleCajaInstance}">
			<ul class="errors" role="alert">
				<g:eachError bean="${detalleCajaInstance}" var="error">
				<li <g:if test="${error in org.springframework.validation.FieldError}">data-field-id="${error.field}"</g:if>><g:message error="${error}"/></li>
				</g:eachError>
			</ul>
			</g:hasErrors>
			<g:form url="[resource:detalleCajaInstance, action:'save']" >
				<fieldset class="form">
					<g:render template="form"/>
				</fieldset>
				<fieldset class="buttons">
					<g:submitButton name="create" class="save" value="${message(code: 'default.button.create.label', default: 'Create')}" />
				</fieldset>
			</g:form>
		</div>
	</body>
</html>