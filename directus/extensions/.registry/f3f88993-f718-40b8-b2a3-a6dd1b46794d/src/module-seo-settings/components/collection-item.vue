<template>
<div class="seo-collection-item group flex flex-col rounded-xl border border-slate-200 bg-white overflow-hidden transition-all duration-300 hover:shadow-lg hover:border-primary/20 hover:-translate-y-1">
    <div class="flex gap-4 px-5 py-5">
        <div class="icon-wrapper self-center group-hover:scale-110 transition-transform duration-300">
            <div class="icon bg-gradient-to-br from-primary-50 to-primary-100 text-primary">
                <v-icon large :name="item?.icon || 'label'" />
            </div>
        </div>
        <div class="collection-content flex-1 min-w-0">
            <div class="text-base font-semibold text-slate-900 truncate">
                {{ item?.name || formatTitle(item?.collection) }}
            </div>
            <div class="text-sm mt-1 text-slate-500 line-clamp-1" :title="item?.meta?.note || '...'">
                {{ item?.meta?.note || '...' }}
            </div>
            <div class="text-xs mt-2 px-2 py-1 bg-slate-100 text-slate-600 rounded-md inline-flex items-center gap-1">
                <span class="w-1.5 h-1.5 rounded-full bg-slate-400"></span>
                Collection: {{ item?.collection }}
            </div>
            <div v-if="item?.translation_collection" class="text-xs mt-1 text-slate-500">
                <span class="inline-flex items-center gap-1 px-2 py-0.5 bg-primary-50 text-primary rounded-md">
                    <v-icon name="globe" class="w-3 h-3" />
                    Translation: {{ item?.translation_collection }}
                </span>
            </div>
        </div>
    </div>
    <div class="flex gap-4 px-5 py-4 justify-between action bg-slate-50 border-t border-slate-100">
        <div class="flex items-center gap-2">
            <v-switch
                :model-value="modelValue"
                @update:model-value="updateValue($event, item?.collection)"
                :disabled="item?.is_new && !item?.translation_collection"
            />
            <span class="text-sm text-slate-600" :class="{ 'text-slate-400': !modelValue }">
                {{ modelValue ? 'Enabled' : 'Disabled' }}
            </span>
        </div>
        <v-button
            class="button-setting"
            :to="`/seo-settings/title-meta/${item?.collection}`"
            :disabled="!modelValue"
            :style="{
                '--v-button-background-color': '#fff',
                '--v-button-color': '#070A13',
                '--border-width': '1px',
                '--v-button-min-width': '0',
                '--v-button-border-color': '#CBD5E1',
                '--v-button-border-radius': '8px',
            }"
        >
            <v-icon name="settings" class="w-4 h-4 mr-1" />
            Setting
        </v-button>
    </div>
    <v-dialog v-model="showDialog" max-width="480px">
        <v-card class="rounded-xl overflow-hidden shadow-xl">
            <v-card-title class="bg-gradient-to-r from-primary-50 to-slate-50 border-b border-slate-100">
                <div class="flex items-center gap-3">
                    <div class="w-10 h-10 rounded-full bg-primary/10 flex items-center justify-center">
                        <v-icon name="info" class="w-5 h-5 text-primary" />
                    </div>
                    <div>
                        <h3 class="font-semibold text-slate-900">Enable SEO for collection</h3>
                        <p class="text-sm text-slate-500">Configure translation settings</p>
                    </div>
                </div>
            </v-card-title>
            <v-card-text class="p-6">
                <div class="space-y-3">
                    <div class="flex items-start gap-3">
                        <v-icon name="file-text" class="w-5 h-5 text-slate-400 mt-0.5 flex-shrink-0" />
                        <p class="text-slate-700">This collection has translation collection: <span class="font-bold text-primary">{{ item?.translation_collection }}</span></p>
                    </div>
                    <div class="flex items-start gap-3">
                        <v-icon name="arrow-right" class="w-5 h-5 text-slate-400 mt-0.5 flex-shrink-0" />
                        <p class="text-slate-700">SEO module uses <span class="font-bold text-primary">{{ item?.translation_collection }}</span> for saving data</p>
                    </div>
                    <div class="flex items-start gap-3">
                        <v-icon name="help-circle" class="w-5 h-5 text-slate-400 mt-0.5 flex-shrink-0" />
                        <p class="text-slate-700">If you want to enable for <span class="font-bold text-primary">{{ item?.collection }}</span> only, choose the option below</p>
                    </div>
                </div>
            </v-card-text>
            <v-card-actions class="p-6 pt-0 flex gap-3 justify-end">
                <v-button 
                    secondary 
                    @click="enabledCollection(false)"
                    class="rounded-lg border-slate-200 hover:border-slate-300 hover:bg-slate-50"
                >
                    Enable for {{ item?.collection }} only
                </v-button>
                <v-button 
                    @click="enabledCollection"
                    class="rounded-lg bg-gradient-to-r from-primary to-primary-dark hover:opacity-90"
                >
                    Enable for {{ item?.translation_collection }}
                </v-button>
            </v-card-actions>
        </v-card>
    </v-dialog>
</div>
</template>

<script setup lang="ts">
import { PropType, ref } from 'vue';
import VSwitch from './v-switch.vue'
import formatTitle from '@directus/format-title';

const props = defineProps({
    item: {
        type: Object as PropType<{[key: string]: any}>,
        default: null
    },
    value: {
        type: Boolean,
        default: null,
    },
    modelValue: {
        type: Boolean,
        default: null
    }
})
const emit = defineEmits(['update:modelValue'])

const showDialog = ref(false)

const updateValue = ($event, collection) => {
    if( props.item?.is_new && props.item?.translation_collection && $event === true ) {
        showDialog.value = true
        return
    }
    emit('update:modelValue', $event, props.item);
}

function enabledCollection(is_translation: boolean = true) {
    showDialog.value = false
    emit('update:modelValue', true, props.item, is_translation);
}
</script>

<style lang="scss" scoped>
@import '../../../styles/base.scss';

.icon-wrapper {
    flex-shrink: 0;
}

.icon {
    display: flex;
    align-items: center;
    justify-content: center;
    width: 56px;
    height: 56px;
    border-radius: 14px;
    transition: all $transition-normal;
}

.button-setting {
    :deep() {
        .button {
            border-color: $slate-300!important;
            transition: all $transition-fast;
            
            &:hover:not(:disabled) {
                border-color: $primary!important;
                background-color: rgba($primary, 0.05)!important;
                color: $primary!important;
            }
            
            &:disabled {
                opacity: 0.5;
                cursor: not-allowed;
            }
        }
    }
}

.seo-collection-item {
    color: $slate-700;
    border-color: $slate-200;
    transition: all $transition-normal;
}

.action {
    background: $slate-50;
}

.line-clamp-1 {
    overflow: hidden;
    display: -webkit-box;
    -webkit-box-orient: vertical;
    -webkit-line-clamp: 1;
}
</style>