project "DPP"
	kind "StaticLib"
	architecture "x86_64"
	language "C++"
	cppdialect "C++20"
	warnings "Off"
	
	-- debugdir ("%{wks.location}/bin/" .. outputdir .. "/%{prj.name}") 
	
	targetdir ("%{wks.location}/bin/" .. outputdir .. "/%{prj.name}")
	objdir ("%{wks.location}/bin-int/" .. outputdir .. "/%{prj.name}")

	files
	{
		"src/dpp/**.h",
		"src/dpp/**.hpp",
		"src/dpp/**.cpp",
	}

	includedirs
	{
		"include",
	}

	filter "system:windows"
		defines "APP_PLATFORM_WINDOWS"
		systemversion "latest"
		staticruntime "on"

        includedirs
        {
            "win32/include"
        }

        links
        {
            "win32/lib/libcrypto.lib",
            "win32/lib/libsodium.lib",
            "win32/lib/libssl.lib",
            "win32/lib/opus.lib",
            "win32/lib/zlib.lib",
        }

        postbuildcommands
        {
            '{COPYFILE} "%{wks.location}/vendor/DPP/win32/bin/libcrypto-1_1-x64.dll" "%{cfg.targetdir}"',
            '{COPYFILE} "%{wks.location}/vendor/DPP/win32/bin/libsodium.dll" "%{cfg.targetdir}"',
            '{COPYFILE} "%{wks.location}/vendor/DPP/win32/bin/libssl-1_1-x64.dll" "%{cfg.targetdir}"',
            '{COPYFILE} "%{wks.location}/vendor/DPP/win32/bin/zlib1.dll" "%{cfg.targetdir}"',
        }

	filter "system:linux"
		defines "APP_PLATFORM_LINUX"
		systemversion "latest"
		staticruntime "on"

	filter "configurations:Debug"
		defines "APP_DEBUG"
		runtime "Debug"
		symbols "on"

	filter "configurations:Release"
		defines "APP_RELEASE"
		runtime "Release"
		optimize "Full"