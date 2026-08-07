package com.runtoolkit.mce.client;

import com.terraformersmc.modmenu.api.ConfigScreenFactory;
import com.terraformersmc.modmenu.api.ModMenuApi;
import net.fabricmc.api.EnvType;
import net.fabricmc.api.Environment;

/**
 * Optional Mod Menu integration. This class is loaded only by Mod Menu's
 * `modmenu` entrypoint, so the mod remains usable without Mod Menu installed.
 */
@Environment(EnvType.CLIENT)
public final class MceModMenuIntegration implements ModMenuApi {
    @Override
    public ConfigScreenFactory<?> getModConfigScreenFactory() {
        return MceInfoScreen::new;
    }
}
