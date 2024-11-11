/*
 * Activiti Modeler component part of the Activiti project
 * Copyright 2005-2014 Alfresco Software, Ltd. All rights reserved.
 * //FHqq-3-1-3-5-9-6-7-9-0
 * This library is free software; you can redistribute it and/or
 * modify it under the terms of the GNU Lesser General Public
 * License as published by the Free Software Foundation; either
 * version 2.1 of the License, or (at your option) any later version.
 *
 * This library is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
 * Lesser General Public License for more details.

 * You should have received a copy of the GNU Lesser General Public
 * License along with this library; if not, write to the Free Software
 * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301  USA
 */
'use strict';

var aclocat = (window.location+'').split('/'); 
if('activiti-editor'== aclocat[3]){aclocat =  aclocat[0]+'//'+aclocat[2];}else{aclocat =  aclocat[0]+'//'+aclocat[2]+'/'+aclocat[3];};

var ACTIVITI = ACTIVITI || {};

ACTIVITI.CONFIG = {
	'contextRoot' : ''+aclocat,
};
