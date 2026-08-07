package com.runtoolkit.mce;

import com.runtoolkit.mce.command.MceCommands;
import com.runtoolkit.mce.item.MceItems;
import net.fabricmc.api.ModInitializer;
import net.fabricmc.fabric.api.event.lifecycle.v1.ServerLifecycleEvents;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

/**
 * Fabric bootstrap for Marker Command Engine.
 *
 * <p>The actual command engine is provided as vanilla datapack resources under
 * {@code src/main/resources/data}. Fabric exposes those resources from the mod
 * JAR like any other mod-provided data pack.</p>
 */
public final class MarkerCommandEngineMod implements ModInitializer {
    public static final String MOD_ID = "marker_command_engine";
    public static final String ENGINE_NAMESPACE = "mce";
    public static final String ENGINE_VERSION = "2.3.1-sec";

    public static final Logger LOGGER = LoggerFactory.getLogger(MOD_ID);

    @Override
    public void onInitialize() {
        MceItems.register();
        MceCommands.register();

        LOGGER.info("Marker Command Engine {} Fabric bootstrap initialized.", ENGINE_VERSION);

        ServerLifecycleEvents.SERVER_STARTED.register(server -> LOGGER.info(
                "Marker Command Engine datapack resources are available. Open the chest GUI with: /mcegui"
        ));
    }
}
