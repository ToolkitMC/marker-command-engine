package com.runtoolkit.mce.gui;

import com.runtoolkit.mce.item.MceItems;
import net.minecraft.inventory.SimpleInventory;
import net.minecraft.item.ItemStack;
import net.minecraft.item.Items;
import net.minecraft.screen.SimpleNamedScreenHandlerFactory;
import net.minecraft.server.network.ServerPlayerEntity;
import net.minecraft.text.Text;
import net.minecraft.util.Formatting;

/** Opens and populates the virtual chest GUI. */
public final class MceChestGui {
    public static final int ROWS = 3;
    public static final int SIZE = ROWS * 9;

    private MceChestGui() {
    }

    public static void open(ServerPlayerEntity player) {
        player.openHandledScreen(new SimpleNamedScreenHandlerFactory(
                (syncId, playerInventory, playerEntity) -> new MceChestScreenHandler(syncId, playerInventory, createInventory()),
                Text.translatable("marker_command_engine.chest.title")
        ));
    }

    static SimpleInventory createInventory() {
        SimpleInventory inventory = new SimpleInventory(SIZE);

        for (int slot = 0; slot < SIZE; slot++) {
            inventory.setStack(slot, filler());
        }

        inventory.setStack(4, named(new ItemStack(MceItems.MCE_CONTROL_PANEL),
                Text.translatable("marker_command_engine.chest.header").formatted(Formatting.GOLD)));

        for (MceGuiAction action : MceGuiAction.values()) {
            ItemStack stack = named(new ItemStack(action.cooldownItem), Text.translatable(action.titleKey).formatted(action.formatting));
            inventory.setStack(action.slot, stack);
        }

        return inventory;
    }

    private static ItemStack filler() {
        ItemStack stack = new ItemStack(Items.GRAY_STAINED_GLASS_PANE);
        stack.setCustomName(Text.literal(" "));
        return stack;
    }

    private static ItemStack named(ItemStack stack, Text name) {
        stack.setCustomName(name);
        return stack;
    }
}
