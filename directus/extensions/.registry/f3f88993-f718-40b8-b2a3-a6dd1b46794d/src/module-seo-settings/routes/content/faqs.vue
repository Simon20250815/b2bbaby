<template>
    <private-view smallHeader title="FAQ Management">
        <template #title>
            <div>
                <h1 class="font-semibold text-lg text-slate-900">{{ 'FAQ Management' }}</h1>
                <div class="text-sm">Manage frequently asked questions and organize by category.</div>
            </div>
        </template>
        <template #actions>
            <v-button
                v-tooltip.bottom="Add New FAQ"
                rounded
                icon
                :disabled="false"
                to="/seo-settings/content/faqs/create"
            >
                <v-icon name="add"></v-icon>
            </v-button>
        </template>
        <template #navigation>
            <navigator />
        </template>
        <div class="py-6 px-7.5">
            <div class="bg-white rounded-xl border border-slate-200 shadow-sm overflow-hidden">
                <div class="p-4 border-b border-slate-100 flex items-center justify-between">
                    <div class="flex items-center gap-4">
                        <div class="relative">
                            <v-icon name="search" class="absolute left-3 top-1/2 -translate-y-1/2 w-4 h-4 text-slate-400" />
                            <input 
                                v-model="searchQuery" 
                                type="text" 
                                placeholder="Search FAQs..." 
                                class="pl-10 pr-4 py-2 border border-slate-200 rounded-lg text-sm w-64 focus:outline-none focus:border-primary focus:ring-2 focus:ring-primary/20"
                            />
                        </div>
                        <select 
                            v-model="filterCategory" 
                            class="px-3 py-2 border border-slate-200 rounded-lg text-sm focus:outline-none focus:border-primary bg-white"
                        >
                            <option value="all">All Categories</option>
                            <option value="product">Product</option>
                            <option value="shipping">Shipping</option>
                            <option value="payment">Payment</option>
                            <option value="return">Return Policy</option>
                        </select>
                    </div>
                    <div class="flex items-center gap-2">
                        <span class="text-sm text-slate-500">Total: {{ faqs.length }}</span>
                    </div>
                </div>
                <div class="divide-y divide-slate-100">
                    <div 
                        v-for="faq in filteredFaqs" 
                        :key="faq.id" 
                        class="px-4 py-4 hover:bg-slate-50 transition-colors"
                    >
                        <div class="flex items-start justify-between">
                            <div class="flex-1">
                                <div class="flex items-center gap-3 mb-2">
                                    <span class="inline-flex items-center px-2.5 py-0.5 rounded-full text-xs font-medium bg-purple-50 text-purple-700">
                                        {{ faq.category || 'General' }}
                                    </span>
                                    <span class="text-sm text-slate-500">#{{ faq.id }}</span>
                                </div>
                                <h3 class="font-medium text-slate-900 mb-1">{{ faq.question }}</h3>
                                <p class="text-sm text-slate-600 line-clamp-2">{{ faq.answer }}</p>
                            </div>
                            <div class="flex items-center gap-2 ml-4">
                                <v-button 
                                    size="small" 
                                    secondary 
                                    :to="`/seo-settings/content/faqs/${faq.id}/edit`"
                                >
                                    <v-icon name="edit" class="w-4 h-4 mr-1" />
                                    Edit
                                </v-button>
                                <v-button 
                                    size="small" 
                                    danger 
                                    @click="deleteFaq(faq)"
                                >
                                    <v-icon name="delete" class="w-4 h-4 mr-1" />
                                    Delete
                                </v-button>
                            </div>
                        </div>
                    </div>
                </div>
                <div v-if="filteredFaqs.length === 0" class="py-12 text-center">
                    <v-icon name="inbox" class="w-12 h-12 text-slate-300 mx-auto mb-4" />
                    <p class="text-slate-500">No FAQs found</p>
                </div>
            </div>
        </div>
        <v-dialog v-model="showDeleteConfirm">
            <v-card class="rounded-xl">
                <v-card-title>Confirm Delete</v-card-title>
                <v-card-text>
                    Are you sure you want to delete this FAQ?
                </v-card-text>
                <v-card-actions>
                    <v-button secondary @click="showDeleteConfirm = false">Cancel</v-button>
                    <v-button danger @click="confirmDelete">Delete</v-button>
                </v-card-actions>
            </v-card>
        </v-dialog>
    </private-view>
</template>

<script setup lang="ts">
import { ref, computed } from 'vue';
import { useApi, useStores } from '@directus/extensions-sdk';
import Navigator from '../../components/navigator/index.vue';

const api = useApi();
const { useNotificationsStore } = useStores();
const notify = useNotificationsStore();

const searchQuery = ref('');
const filterCategory = ref('all');
const faqs = ref([]);
const showDeleteConfirm = ref(false);
const deletingFaq = ref(null);

const filteredFaqs = computed(() => {
    let result = faqs.value;
    if (searchQuery.value) {
        const query = searchQuery.value.toLowerCase();
        result = result.filter(f => 
            f.question.toLowerCase().includes(query) || 
            f.answer.toLowerCase().includes(query)
        );
    }
    if (filterCategory.value !== 'all') {
        result = result.filter(f => f.category === filterCategory.value);
    }
    return result.sort((a, b) => (a.sort || 0) - (b.sort || 0));
});

async function loadFaqs() {
    try {
        const response = await api.get('/items/faqs', {
            params: {
                fields: ['id', 'question', 'answer', 'category', 'sort'],
                limit: -1
            }
        });
        faqs.value = response.data.data;
    } catch (error) {
        console.error('Failed to load FAQs:', error);
        notify.add({ title: 'Error loading FAQs', type: 'error' });
    }
}

function deleteFaq(faq) {
    deletingFaq.value = faq;
    showDeleteConfirm.value = true;
}

async function confirmDelete() {
    try {
        await api.delete(`/items/faqs/${deletingFaq.value.id}`);
        faqs.value = faqs.value.filter(f => f.id !== deletingFaq.value.id);
        notify.add({ title: 'FAQ deleted successfully' });
    } catch (error) {
        notify.add({ title: 'Error deleting FAQ', type: 'error' });
    }
    showDeleteConfirm.value = false;
    deletingFaq.value = null;
}

loadFaqs();
</script>