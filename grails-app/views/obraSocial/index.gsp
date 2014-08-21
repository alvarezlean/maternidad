
<%@ page import="maternidad.ObraSocial" %>
<!DOCTYPE html>
<html>
	<head>
		<meta name="layout" content="main">
		<g:set var="entityName" value="${message(code: 'obraSocial.label', default: 'ObraSocial')}" />
		<title><g:message code="default.list.label" args="[entityName]" /></title>
	</head>
	<body>
		<a href="#list-obraSocial" class="skip" tabindex="-1"><g:message code="default.link.skip.label" default="Skip to content&hellip;"/></a>
		<div class="nav" role="navigation">
			<ul>
				<li><a class="home" href="${createLink(uri: '/')}"><g:message code="default.home.label"/></a></li>
				<li><g:link class="create" action="create"><g:message code="default.new.label" args="[entityName]" /></g:link></li>
			</ul>
		</div>
		<div id="list-obraSocial" class="content scaffold-list" role="main">
			<h1><g:message code="default.list.label" args="[entityName]" /></h1>
			<g:if test="${flash.message}">
				<div class="message" role="status">${flash.message}</div>
			</g:if>

            <div class="filters">
                <g:form action="index">

                    <table>
                        <tr>
                            <td> <p><label for="sigla">Sigla</label>
                                <g:textField name="sigla" value="${filters?.sigla}" /></p></td>
                            <td>
                                <p><label for="codigo">Código</label>
                                    <g:textField name="codigo" value="${filters?.codigo}" /></p></td>

                            <td>
                                <p><label for="nombre">Nombre</label>
                                    <g:textField id="nombre" name="nombre" value="${filters?.nombre}" /></p></td>

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
	</body>
</html>
