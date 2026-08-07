package com.runtoolkit.mce.client;

import com.runtoolkit.mce.MarkerCommandEngineMod;
import net.fabricmc.api.ClientModInitializer;
import net.fabricmc.fabric.api.client.event.lifecycle.v1.ClientTickEvents;
import net.fabricmc.fabric.api.client.keybinding.v1.KeyBindingHelper;
import net.minecraft.client.MinecraftClient;
import net.minecraft.client.option.KeyBinding;
import net.minecraft.client.util.InputUtil;
import net.minecraft.text.Text;
import org.lwjgl.glfw.GLFW;

/** Client bootstrap for opening the server-side MCE chest GUI. */
public final class MarkerCommandEngineClient implements ClientModInitializer {
    private static KeyBinding openGuiKey;

    @Override
    public void onInitializeClient() {
        openGuiKey = KeyBindingHelper.registerKeyBinding(new KeyBinding(
                "key.marker_command_engine.open_gui",
                InputUtil.Type.KEYSYM,
                GLFW.GLFW_KEY_UNKNOWN,
                "category.marker_command_engine"
        ));

        ClientTickEvents.END_CLIENT_TICK.register(client -> {
            while (openGuiKey.wasPressed()) {
                MceClientCommandSender.sendServerCommand("mcegui");
            }
        });

        MarkerCommandEngineMod.LOGGER.info("Marker Command Engine client keybind initialized. Open the chest GUI with /mcegui or the MCE key.");
    }

    static void sendFeedback(Text text) {
        MinecraftClient client = MinecraftClient.getInstance();
        if (client.player != null) {
            client.player.sendMessage(text, false);
        }
    }
}
