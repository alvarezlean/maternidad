<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main">
    <g:set var="entityName" value="${message(code: 'planillaInternacion.label', default: 'PlanillaInternacion')}"/>
    <title><g:message code="planillaInternacion.create.label" args="[entityName]"/></title>
    <script>
        $(function() {
            //idioma de los calendar
            jQuery.datepicker.regional[ "es" ];
            updateDatePicker();
            jQuery("#spinner").ajaxComplete(function (event, request, settings) {
                updateDatePicker();
            });

            $("#localidad").select2({allowClear: true});
            $("#plan").select2({allowClear: true});

        })
    </script>
</head>

<body>
<a href="#create-planillaInternacion" class="skip" tabindex="-1"><g:message code="default.link.skip.label"
                                                                            default="Skip to content&hellip;"/></a>

<div class="nav" role="navigation">
    <ul>
      <!--  <li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li> -->
        <li><g:link class="list" action="index"><g:message code="planillaInternacion.list.label" args="[entityName]"/></g:link></li>
    </ul>
</div>

<div id="create-planillaInternacion" class="content scaffold-create" role="main">
    <h1><g:message code="default.create.label" args="[entityName]"/></h1>
    <g:if test="${flash.message}">
        <div class="message" role="status">${flash.message}</div>
    </g:if>
    <g:hasErrors bean="${planillaInternacionInstance}">
        <ul class="errors" role="alert">
            <g:eachError bean="${planillaInternacionInstance}" var="error">
                <li <g:if test="${error in org.springframework.validation.FieldError}">data-field-id="${error.field}"</g:if>><g:message
                        error="${error}"/></li>
            </g:eachError>
        </ul>
    </g:hasErrors>
    <g:hasErrors bean="${personaInstance}">
        <ul class="errors" role="alert">
            <g:eachError bean="${personaInstance}" var="error">
                <li <g:if test="${error in org.springframework.validation.FieldError}">data-field-id="${error.field}"</g:if>><g:message
                        error="${error}"/></li>
            </g:eachError>
        </ul>
    </g:hasErrors>
    <g:form url="[resource: planillaInternacionInstance, action: 'saveconpersona']">
        <fieldset class="form">
            <g:render template="persona"/>
        </fieldset>
        <fieldset class="form">
            <g:render template="form"/>
        </fieldset>
        <fieldset class="buttons">
            <g:submitButton name="create" class="save"
                            value="${message(code: 'default.button.create.label', default: 'Create')}"/>
        </fieldset>
    </g:form>
</div>
</body>
</html>
