<%@ page import="maternidad.Factura" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'factura.label', default: 'Factura')}" />
		<title><g:message code="default.edit.label" args="[entityName]" /></title>



	</head>
	<body>
		<a href="#edit-factura" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<!--<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>-->
				<li><g:link class="list" action="index"><g:message code="default.list.label" args="[entityName]" /></g:link></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="edit-factura" class="content scaffold-edit" role="main">
			<h1><g:message code="default.edit.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
			<div class="message" role="status">${flash.message}</div>
			</g:if>
			<g:hasErrors bean="${facturaInstance}">
			<ul class="errors" role="alert">
				<g:eachError bean="${facturaInstance}" var="error">
				<li <g:if test="${error in org.springframework.validation.FieldError}">data-field-id="${error.field}"</g:if>><g:message error="${error}"/></li>
				</g:eachError>
			</ul>
			</g:hasErrors>
			<g:form id="formulario" url="[resource:facturaInstance, action:'update']" method="PUT" >
				<g:hiddenField name="version" value="${facturaInstance?.version}" />
				<fieldset class="form">
					<g:render template="formedit"/>
				</fieldset>
				<fieldset class="buttons">
					<g:actionSubmit id="boton" class="save" action="update" value="${message(code: 'default.button.update.label', default: 'Update')}" />
				</fieldset>
			</g:form>
		</div>


    <script>
        $(function() {

            jQuery("#boton").click(function(e){
                e.preventDefault();

                jQuery("#formulario").find(':input').removeAttr( "disabled" );
                jQuery("#formulario").submit();
            });


            jQuery("#plan").attr('readonly',true);

        })

    </script>

	</body>
</html>
