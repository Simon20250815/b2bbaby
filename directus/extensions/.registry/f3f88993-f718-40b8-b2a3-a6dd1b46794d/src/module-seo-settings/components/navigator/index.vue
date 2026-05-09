<template>
    <div class="navigator h-full flex flex-col">
        <div class="nav-header px-4 py-4 border-b border-slate-200">
            <div class="flex items-center gap-3">
                <div class="w-9 h-9 rounded-xl bg-gradient-to-br from-primary to-primary-dark flex items-center justify-center">
                    <v-icon name="search" class="w-5 h-5 text-white" />
                </div>
                <div>
                    <div class="text-sm font-semibold text-slate-900">SEO Settings</div>
                    <div class="text-xs text-slate-500">Optimize your content</div>
                </div>
            </div>
        </div>
        <v-list v-model="openDetail" class="flex-1 overflow-y-auto">
            <v-list-group
                v-for="item, index in items"
                :class="{'hidden': item?.hidden }"
            >
                <template #activator>
                    <div 
                        class="nav-item flex items-center text-slate-700 mr-auto cursor-pointer group"
                        :class="{ 'active': isActive(item?.to) }"
                        @click="router.push(item?.to)"
                    >
                        <v-list-item-icon class="nav-icon-wrapper">
                            <v-icon :name="item.icon" class="nav-icon" />
                        </v-list-item-icon>
                        <v-list-item-content>
                            <v-text-overflow :text="item.name" class="font-medium" />
                        </v-list-item-content>
                        <v-icon 
                            v-if="item?.childrens?.length" 
                            name="chevron_right" 
                            class="transition-transform duration-200 ml-auto"
                            :class="{ 'rotate-90': openDetail.includes(item?.to) }"
                        />
                    </div>
                </template>
                <v-list-item
                    v-for="child, childIndex in item?.childrens"
                    :key="child.to" 
                    :to="child.to"
                    :class="{'!hidden': child?.hidden, 'child-item': true}"
                >
                    <v-list-item-icon>
                        <div class="w-1.5 h-1.5 rounded-full bg-slate-400 group-hover:bg-primary transition-colors"></div>
                    </v-list-item-icon>
                    <v-list-item-content>
                        <v-text-overflow :text="child.name" />
                    </v-list-item-content>
                </v-list-item>
            </v-list-group>
        </v-list>
        <div class="nav-footer px-4 py-3 border-t border-slate-200 bg-slate-50">
            <div class="text-xs text-slate-500 text-center">
                SEO Extensions v{{__EXTENSION_VERSION__}}
            </div>
        </div>
    </div>
</template>

<script setup lang="ts">
import { computed, PropType, ref } from 'vue';
import { useI18n } from 'vue-i18n';
import { useRoute, useRouter } from 'vue-router'
import type { NavigatorItem } from './types'
import { navigatorItems } from '../../constants'
import { __EXTENSION_VERSION__ } from '../../../shared/constants';

const props = defineProps({
    activeItem: {
        type: [Number, String],
        default: 0
    }
})

const route = useRoute()
const router = useRouter()

const openDetail = ref<string[]>([]);
const items = ref(navigatorItems)

const isActive = (path: string) => {
    return route.path.includes(path)
}
</script>

<style lang="scss" scoped>
@import '../../../styles/base.scss';

.navigator {
    --v-list-padding: 0;
    --v-list-item-margin: 0;
    background-color: #ffffff;
    border-radius: $radius-lg;
    box-shadow: $shadow-sm;
    overflow: hidden;
    border: 1px solid $slate-200;

    :deep() {
        .v-list-group {
            margin-bottom: 0;
            border-bottom: none;
            
            .items {
                background-color: $slate-50;
                border-radius: 0 0 $radius-md $radius-md;
                overflow: hidden;
                
                .v-list-item {
                    padding: 10px 12px 10px 42px;
                    transition: all $transition-fast;
                    
                    &:hover {
                        background-color: rgba($primary, 0.06);
                        color: $primary;
                    }
                }
            }
            
            .items:not(:empty) {
                padding: 0;
                border-top: 1px solid $slate-100;
                margin-top: 0;
            }
            
            .v-list-item-icon {
                margin-top: 0;
                margin-bottom: 0;
            }
        }
        
        li.v-list-item.activator {
            padding: 14px 16px;
            background-color: transparent;
            border-radius: $radius-md;
            margin: 0 8px;
            transition: all $transition-fast;
            
            &:hover {
                background-color: $slate-50;
            }
            
            &.active {
                background-color: rgba($primary, 0.08);
                
                .nav-icon-wrapper {
                    background-color: rgba($primary, 0.12);
                }
                
                .nav-icon {
                    color: $primary;
                }
                
                .v-text-overflow {
                    color: $primary;
                }
            }
            
            > a {
                padding-left: 0;
                width: 100%;
                
                .v-list-item-icon {
                    margin-right: 10px;
                }
            }
        }
    }
}

.nav-header {
    background: linear-gradient(135deg, $primary-50 0%, $slate-50 100%);
}

.nav-icon-wrapper {
    width: 32px;
    height: 32px;
    border-radius: $radius-md;
    display: flex;
    align-items: center;
    justify-content: center;
    background-color: $slate-100;
    transition: all $transition-fast;
}

.nav-icon {
    color: $slate-600;
    transition: all $transition-fast;
}

.nav-item:hover {
    .nav-icon-wrapper {
        background-color: rgba($primary, 0.1);
    }
    
    .nav-icon {
        color: $primary;
    }
}

.child-item {
    :deep() {
        .v-list-item-icon {
            min-width: 24px;
            display: flex;
            align-items: center;
            justify-content: center;
        }
        
        &:hover {
            .w-1.5 {
                background-color: $primary;
            }
        }
    }
}

.nav-footer {
    background: linear-gradient(180deg, $slate-50 0%, white 100%);
}

.rotate-90 {
    transform: rotate(90deg);
}
</style>