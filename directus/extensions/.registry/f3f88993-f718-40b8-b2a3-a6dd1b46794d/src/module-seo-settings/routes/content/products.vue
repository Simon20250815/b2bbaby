<template>
    <private-view smallHeader title="Product Management">
        <template #title>
            <div>
                <h1 class="font-semibold text-lg text-slate-900">{{ 'Product Management' }}</h1>
                <div class="text-sm">Manage your products, edit details, and control visibility.</div>
            </div>
        </template>
        <template #actions>
            <v-button
                v-tooltip.bottom="Add New Product"
                rounded
                icon
                :disabled="false"
                to="/seo-settings/content/products/create"
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
                                placeholder="Search products..." 
                                class="pl-10 pr-4 py-2 border border-slate-200 rounded-lg text-sm w-64 focus:outline-none focus:border-primary focus:ring-2 focus:ring-primary/20"
                            />
                        </div>
                        <select 
                            v-model="filterStatus" 
                            class="px-3 py-2 border border-slate-200 rounded-lg text-sm focus:outline-none focus:border-primary bg-white"
                        >
                            <option value="all">All Status</option>
                            <option value="published">Published</option>
                            <option value="draft">Draft</option>
                        </select>
                    </div>
                    <div class="flex items-center gap-2">
                        <span class="text-sm text-slate-500">Total: {{ products.length }}</span>
                    </div>
                </div>
                <div class="overflow-x-auto">
                    <table class="w-full">
                        <thead>
                            <tr class="bg-slate-50">
                                <th class="px-4 py-3 text-left text-xs font-semibold text-slate-500 uppercase tracking-wider">Image</th>
                                <th class="px-4 py-3 text-left text-xs font-semibold text-slate-500 uppercase tracking-wider">Title</th>
                                <th class="px-4 py-3 text-left text-xs font-semibold text-slate-500 uppercase tracking-wider">Category</th>
                                <th class="px-4 py-3 text-left text-xs font-semibold text-slate-500 uppercase tracking-wider">MOQ</th>
                                <th class="px-4 py-3 text-left text-xs font-semibold text-slate-500 uppercase tracking-wider">Certifications</th>
                                <th class="px-4 py-3 text-left text-xs font-semibold text-slate-500 uppercase tracking-wider">Status</th>
                                <th class="px-4 py-3 text-left text-xs font-semibold text-slate-500 uppercase tracking-wider">Actions</th>
                            </tr>
                        </thead>
                        <tbody class="divide-y divide-slate-100">
                            <tr v-for="product in filteredProducts" :key="product.id" class="hover:bg-slate-50 transition-colors">
                                <td class="px-4 py-4">
                                    <img 
                                        :src="product.image || 'https://via.placeholder.com/64'" 
                                        :alt="product.title"
                                        class="w-14 h-14 rounded-lg object-cover"
                                    />
                                </td>
                                <td class="px-4 py-4">
                                    <div class="font-medium text-slate-900">{{ product.title }}</div>
                                    <div class="text-sm text-slate-500">{{ product.slug }}</div>
                                </td>
                                <td class="px-4 py-4">
                                    <span class="inline-flex items-center px-2.5 py-0.5 rounded-full text-xs font-medium bg-slate-100 text-slate-700">
                                        {{ product.category }}
                                    </span>
                                </td>
                                <td class="px-4 py-4 text-slate-600">{{ product.moq }} pcs</td>
                                <td class="px-4 py-4">
                                    <div class="flex flex-wrap gap-1">
                                        <span 
                                            v-for="cert in (product.certifications || []).slice(0, 3)" 
                                            :key="cert"
                                            class="inline-flex items-center px-2 py-0.5 rounded text-xs font-medium bg-green-50 text-green-700"
                                        >
                                            {{ cert }}
                                        </span>
                                        <span v-if="(product.certifications || []).length > 3" class="text-xs text-slate-400">
                                            +{{ (product.certifications || []).length - 3 }}
                                        </span>
                                    </div>
                                </td>
                                <td class="px-4 py-4">
                                    <span 
                                        :class="[
                                            'inline-flex items-center px-2.5 py-0.5 rounded-full text-xs font-medium',
                                            product.status === 'published' ? 'bg-green-50 text-green-700' : 'bg-yellow-50 text-yellow-700'
                                        ]"
                                    >
                                        <span class="w-1.5 h-1.5 rounded-full mr-1.5" :class="product.status === 'published' ? 'bg-green-500' : 'bg-yellow-500'"></span>
                                        {{ product.status }}
                                    </span>
                                </td>
                                <td class="px-4 py-4">
                                    <div class="flex items-center gap-2">
                                        <v-button 
                                            size="small" 
                                            secondary 
                                            :to="`/seo-settings/content/products/${product.id}/edit`"
                                        >
                                            <v-icon name="edit" class="w-4 h-4 mr-1" />
                                            Edit
                                        </v-button>
                                        <v-button 
                                            size="small" 
                                            danger 
                                            @click="deleteProduct(product)"
                                        >
                                            <v-icon name="delete" class="w-4 h-4 mr-1" />
                                            Delete
                                        </v-button>
                                    </div>
                                </td>
                            </tr>
                        </tbody>
                    </table>
                </div>
                <div v-if="filteredProducts.length === 0" class="py-12 text-center">
                    <v-icon name="inbox" class="w-12 h-12 text-slate-300 mx-auto mb-4" />
                    <p class="text-slate-500">No products found</p>
                </div>
            </div>
        </div>
        <v-dialog v-model="showDeleteConfirm">
            <v-card class="rounded-xl">
                <v-card-title>Confirm Delete</v-card-title>
                <v-card-text>
                    Are you sure you want to delete "{{ deletingProduct?.title }}" ?
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
const filterStatus = ref('all');
const products = ref([]);
const showDeleteConfirm = ref(false);
const deletingProduct = ref(null);

const filteredProducts = computed(() => {
    let result = products.value;
    if (searchQuery.value) {
        const query = searchQuery.value.toLowerCase();
        result = result.filter(p => 
            p.title.toLowerCase().includes(query) || 
            p.slug.toLowerCase().includes(query) ||
            p.category.toLowerCase().includes(query)
        );
    }
    if (filterStatus.value !== 'all') {
        result = result.filter(p => p.status === filterStatus.value);
    }
    return result;
});

async function loadProducts() {
    try {
        const response = await api.get('/items/products', {
            params: {
                fields: ['id', 'title', 'slug', 'category', 'moq', 'image', 'certifications', 'status'],
                limit: -1,
                sort: 'sort'
            }
        });
        products.value = response.data.data.map(p => ({
            ...p,
            image: p.image ? `${import.meta.env.DIRECTUS_URL || 'http://localhost:8055'}/assets/${p.image.id}` : null
        }));
    } catch (error) {
        console.error('Failed to load products:', error);
        notify.add({ title: 'Error loading products', type: 'error' });
    }
}

function deleteProduct(product) {
    deletingProduct.value = product;
    showDeleteConfirm.value = true;
}

async function confirmDelete() {
    try {
        await api.delete(`/items/products/${deletingProduct.value.id}`);
        products.value = products.value.filter(p => p.id !== deletingProduct.value.id);
        notify.add({ title: 'Product deleted successfully' });
    } catch (error) {
        notify.add({ title: 'Error deleting product', type: 'error' });
    }
    showDeleteConfirm.value = false;
    deletingProduct.value = null;
}

loadProducts();
</script>