section '.rsrc' resource data readable
	directory	RT_VERSION,versions,RT_MANIFEST,_manifest,RT_ICON,icons,RT_GROUP_ICON,group_icons
	resource	icons,1,LANG_NEUTRAL,icon_data
	resource	group_icons,114,LANG_NEUTRAL,main_icon
	resource	versions,1,LANG_NEUTRAL,version
        resource	_manifest,1,LANG_NEUTRAL,manifest
	icon		main_icon,icon_data,'icon.ico'
	
        versioninfo	version,VOS__WINDOWS32,VFT_APP,VFT2_UNKNOWN,LANG_ENGLISH+SUBLANG_DEFAULT,0,\
		'FileDescription','Key generator',\
		'LegalCopyright','2010-2012 ACME Inc.'

	resdata	manifest
		file 'manifest.xml'
	endres
